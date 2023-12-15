using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Xml.Linq;
using System.IO;

namespace ApartmentsManager2.Controllers
{
    public class UsersController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();
        ~UsersController()
        {
            db.Dispose();
        }
        // GET: Users
        public ActionResult Index()
        {
            return View(db.Users);
        }

        // GET: Users/Details/5
        public ActionResult Details(int? id)
        {
            return CommonAction(id);
        }

        private ActionResult CommonAction(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            var user = db.Users
                .Include(u => u.UploadedFile)
                .SingleOrDefault(u => u.Id_User == id);
            if(user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Users/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        [HttpPost]
        public ActionResult Create(User user)
        {
            if (ModelState.IsValid)
            {
                if (user.UploadedFilesHttp != null && user.UploadedFilesHttp.ContentLength > 0)
                {
                    var uploadedFile = new UploadedFile
                    {
                        Name = Path.GetFileName(user.UploadedFilesHttp.FileName),
                        ContentType = user.UploadedFilesHttp.ContentType
                    };

                    using (var reader = new BinaryReader(user.UploadedFilesHttp.InputStream))
                    {
                        uploadedFile.Content = reader.ReadBytes(user.UploadedFilesHttp.ContentLength);
                    }

                    user.UploadedFile = uploadedFile;
                }

                db.Users.Add(user);
                db.SaveChanges();

                return RedirectToAction(nameof(Index));
            }

            return View(user);
        }


        // GET: Users/Edit/5
        public ActionResult Edit(int? id)
        {
            return CommonAction(id);
        }
        // POST: Apartment/Create
        [HttpPost]
        public ActionResult Edit(int id)
        {
            var user = db.Users.Find(id);
            if (TryUpdateModel(
                    user,
                    "",
                    new string[]
                    {
                        "Name",
                        "Surname",
                        "email",
                        "UploadedFile"
                    }
                ))
            {
                if (Request.Files.Count == 1)
                {
                    var file = Request.Files[0];

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

                        user.UploadedFile = uploadedFile;
                    }
                }
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(user);
        }

        // GET: Users/Delete/5
        public ActionResult Delete(int? id)
        {
            return CommonAction(id);
        }

        // POST: Users/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            db.UploadedFiles.RemoveRange(db.UploadedFiles.Where(
                f => f.User.Id_User == id));
            db.Apartments.RemoveRange(db.Apartments.Where(
                a => a.Contact == id));
            db.Reservations.RemoveRange(db.Reservations.Where(
                r => r.ApartmentId_Aparment == id));
            db.Users.Remove(db.Users.Find(id));
            db.SaveChanges();
            return RedirectToAction(nameof(Index));
        }
    }
}
