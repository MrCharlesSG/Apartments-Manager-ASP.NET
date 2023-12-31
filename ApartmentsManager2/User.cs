//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ApartmentsManager2
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Web;
    using System.Web.Helpers;

    public partial class User
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public User()
        {
            this.Apartments = new HashSet<Apartment>();
            this.Reservations = new HashSet<Reservation>();
        }
    
        public int Id_User { get; set; }
        [Required]
        [MaxLength(20, ErrorMessage = "{0} cannot be longer than 20")]
        public string Name { get; set; }
        [Required]
        [MaxLength(20, ErrorMessage = "{0} cannot be longer than 20")]
        public string Surname { get; set; }
        [Required]
        [MaxLength(20, ErrorMessage = "{0} cannot be longer than 50")]
        public string email { get; set; }

        public string UserInfo => $"{Name} {Surname}, {email}";

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Apartment> Apartments { get; set; }
        
        [Display(Name = "Avatar")]
        public virtual UploadedFile UploadedFile { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Reservation> Reservations { get; set; }


        [DataType(DataType.Upload)]
        [Display(Name = "Picture")]
        public HttpPostedFileBase UploadedFilesHttp { get; set; }
    }
}
