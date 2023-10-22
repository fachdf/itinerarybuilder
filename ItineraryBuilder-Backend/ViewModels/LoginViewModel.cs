using System.ComponentModel.DataAnnotations;

namespace ItineraryBuilder_Backend.ViewModels
{
    public class LoginViewModel
    {
        [Required]
        [StringLength(50)]
        [EmailAddress]
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
