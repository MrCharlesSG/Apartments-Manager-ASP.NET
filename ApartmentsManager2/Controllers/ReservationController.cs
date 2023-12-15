using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ApartmentsManager2.Controllers
{
    public class ReservationController : Controller
    {
        private readonly ModelContainer db = new ModelContainer();
        ~ReservationController()
        {
            db.Dispose();
        }
        // GET: Reservation
        public ActionResult Index()
        {
            return View(db.Reservations);
        }

        // GET: Reservation/Details/5
        public ActionResult Details(int id)
        {
            return CommonAction(id);
        }

        // GET: Reservation/Create
        public ActionResult Create()
        {
            Reservation reservation = new Reservation();
            SetupSelectedList(reservation);
            return View(reservation);
        }

        private void SetupSelectedList(Reservation reservation)
        {
            reservation.ApartmentsToSelect = new SelectList(db.Apartments, "Id_Aparment", "ApartmentInfo");
            reservation.UsersToSelect = new SelectList(db.Users, "Id_User", "UserInfo");
        }

        // POST: Reservation/Create
        [HttpPost]
        public ActionResult Create(Reservation reservation)
        {
            if (ModelState.IsValid && datesAreValid(reservation))
            {
                db.Reservations.Add(reservation);
                db.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            SetupSelectedList(reservation);
            return View(reservation);
        }

        private bool datesAreValid(Reservation reservation)
        {
            if(reservation ==null) return false;
            if(reservation.Start_Date > reservation.End_Date) return false;
            return isApartmentAvailable(reservation);
        }

        private bool isApartmentAvailable(Reservation reservation)
        {
            var existingReservations = db.Apartments.Find(reservation.ApartmentId_Aparment).Reservations;
            foreach (var existingReservation in existingReservations)
            {
                if(existingReservation.Start_Date <= reservation.Start_Date 
                    && existingReservation.End_Date >= reservation.Start_Date
                    || existingReservation.End_Date >= reservation.End_Date
                    && existingReservation.Start_Date <= reservation.End_Date
                    || existingReservation.End_Date <= reservation.End_Date
                    && existingReservation.Start_Date >= reservation.Start_Date
                    ) { return false; }
            }

            return true;
        }


        // GET: Reservation/Edit/5
        public ActionResult Edit(int? id)
        {
            return CommonAction(id);
        }

        // POST: Reservation/Edit/5
        [HttpPost]
        public ActionResult Edit(int id)
        {
            var reservation = db.Reservations.Find(id);
            if (ModelState.IsValid)
            {
                if (TryUpdateModel(
                    reservation,
                    "",
                    new string[] { "UserId_User", "ApartmentId_Aparment", "Start_Date", "End_Date" }
                ))
                {
                    db.Entry(reservation).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction(nameof(Index));
                }
            }
            return View(reservation);
        }

        // GET: Reservation/Delete/5
        public ActionResult Delete(int? id)
        {
            return CommonAction(id);
        }

        // POST: Reservation/Delete/5
        [HttpPost]
        public ActionResult Delete(int id)
        {
            db.Reservations.Remove(db.Reservations.Find(id));
            db.SaveChanges();
            return RedirectToAction(nameof(Index));
        }

        private ActionResult CommonAction(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);
            }
            var reservation = db.Reservations
                .SingleOrDefault(a => a.Id == id);
            if (reservation == null)
            {
                return HttpNotFound();
            }
            return View(reservation);
        }
    }
}
