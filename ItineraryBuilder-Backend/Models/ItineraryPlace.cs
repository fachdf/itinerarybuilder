using System.Text.Json.Serialization;

namespace ItineraryBuilder_Backend.Models
{
    public class ItineraryPlace
    {
        public int Id { get; set; } 
        public int Number { get; set; }
        public int VisitTime { get; set; }
        public int IsVisited { get; set; }  
        public int PlaceId { get; set; } // Foreign key to Place

        public Place Place { get; set; } // Navigation property
        public int ItineraryId { get; set; } // Foreign key to Itinerary
        [JsonIgnore]
        public Itinerary Itinerary { get; set; } // Navigation property
    }

}
