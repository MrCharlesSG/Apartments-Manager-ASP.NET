using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ApartmentsManager2.Controllers
{
    public class FileController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();

        ~FileController() 
        {
            db.Dispose();
        }

        // GET: File
        public ActionResult Index(int id)
        {
            var uploadedFile = db.UploadedFiles.Find(id);
            return File(uploadedFile.Content, uploadedFile.ContentType);
        }
        public ActionResult Delete(int id)
        {
            UploadedFile file = db.UploadedFiles.Find(id);
            if(file != null)
            {
                db.UploadedFiles.Remove(file);
                db.SaveChanges();
            }
            return Redirect(Request.UrlReferrer.AbsolutePath);
        }
    }
}