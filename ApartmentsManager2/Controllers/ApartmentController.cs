using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Common.CommandTrees;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

namespace ApartmentsManager2.Controllers
{
    public class ApartmentController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();
        ~ApartmentController()
        {
            db.Dispose();
        }
        // GET: Apartment
        public ActionResult Index()
        {
            return View(db.Apartments);
        }

        // GET: Apartment/Details/5
        public ActionResult Details(int id)
        {
            return CommonAction(id, false);
        }

        // GET: Apartment/Create
        public ActionResult Create()
        {
            Apartment ap = new Apartment();
            SetupSelectedList(ap);
            return View(ap);
        }

        private void SetupSelectedList(Apartment ap)
        {
            ap.UsersToSelect = new SelectList(db.Users, "Id_User", "UserInfo");
        }

        // POST: Apartment/Create
        [HttpPost]
        public ActionResult Create(Apartment apartment)
        {
            if (ModelState.IsValid)
            {
                if (apartment.UploadedFilesHttp != null && apartment.UploadedFilesHttp.Any())
                {
                    foreach (var file in apartment.UploadedFilesHttp)
                    {
                        if (file != null)
                        {
                            var uploadedFile = new UploadedFile
                            {
                                Name = Path.GetFileName(file.FileName),
                                ContentType = file.ContentType
                            };

                            using (var reader = new BinaryReader(file.InputStream))
                            {
                                uploadedFile.Content = reader.ReadBytes(file.ContentLength);
                            }

                            apartment.UploadedFiles.Add(uploadedFile);
                        }
                    }
                }
                db.Apartments.Add(apartment);
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            SetupSelectedList(apartment);
            return View(apartment);
        }
        
        // GET: Apartment/Edit/5
        public ActionResult Edit(int? id)
        {
            return CommonAction(id, true);
        }

        // POST: Apartment/Edit/5
        [HttpPost]
        public ActionResult Edit(int id)
        {
            var apartment = db.Apartments.Find(id);
            if (ModelState.IsValid)
            {
                if (TryUpdateModel(
                    apartment,
                    "",
                    new string[] { "Address", "City", "Contact" }
                ))
                {
                    // Check if files are uploaded
                    if (Request.Files.Count > 0)
                    {
                        for (int i = 0; i < Request.Files.Count; i++)
                        {
                            var file = Request.Files[i];

                            if (file != null && file.ContentLength > 0)
                            {
                                var uploadedFile = new UploadedFile
                                {
                                    Name = Path.GetFileName(file.FileName),
                                    ContentType = file.ContentType
                                };

                                using (var reader = new BinaryReader(file.InputStream))
                                {
                                    uploadedFile.Content = reader.ReadBytes(file.ContentLength);
                                }

                                apartment.UploadedFiles.Add(uploadedFile);
                            }
                        }
                    }

                    db.Entry(apartment).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction(nameof(Index));
                }
            }
            return View(apartment);
        }

        // GET: Apartment/Delete/5
        public ActionResult Delete(int? id)
        {
            return CommonAction(id, false);
        }

        // POST: Apartment/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            db.UploadedFiles.RemoveRange(db.UploadedFiles.Where(
                f => f.Apartment.Id_Aparment == id));
            db.Reservations.RemoveRange(db.Reservations.Where(
                r => r.ApartmentId_Aparment == id));
            db.Apartments.Remove(db.Apartments.Find(id));
            db.SaveChanges();
            return RedirectToAction(nameof(Index));
        }

        private ActionResult CommonAction(int? id, bool isEdit)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            var apartment = db.Apartments
                .Include(a => a.UploadedFiles)
                .SingleOrDefault(a => a.Id_Aparment == id);
            if (apartment == null)
            {
                return HttpNotFound();
            }
            else if (isEdit)
            {
                SetupSelectedList(apartment);
            }
            return View(apartment);
        }
    }
}
