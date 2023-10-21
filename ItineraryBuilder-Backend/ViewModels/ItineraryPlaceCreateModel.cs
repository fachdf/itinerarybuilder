namespace ItineraryBuilder_Backend.ViewModels
{
    public class ItineraryPlaceCreateModel
    {
        public int ItineraryId { get; set; }
        public int PlaceId { get; set; }
        public int Number { get; set; }
        public int VisitTime { get; set; }
        public int IsVisited { get; set; }
    }
}
