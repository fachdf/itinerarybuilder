using System.ComponentModel.DataAnnotations.Schema;

namespace ItineraryBuilder_Backend.Models
{
    public class Place
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Address { get; set; }
        public string? Description { get; set; }
        public List<Photo> Photos { get; set; }
        public int? VisitTime { get; set; }
        public Place() { }
    }
}
