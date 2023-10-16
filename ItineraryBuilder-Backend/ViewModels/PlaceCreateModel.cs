namespace ItineraryBuilder_Backend.ViewModels
{
    public class PlaceCreateModel
    {
        public string Name { get; set; }
        public string Address { get; set; }
        public string Description { get; set; }
        public List<PhotoCreateModel> Photos { get; set; }
        public int VisitTime { get; set; }
    }
}
