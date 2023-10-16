using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ItineraryBuilder_Backend;
using ItineraryBuilder_Backend.Models;

public class ItineraryBuilderContext : DbContext
    {
        public ItineraryBuilderContext (DbContextOptions<ItineraryBuilderContext> options)
            : base(options)
        {
            
        }

        public DbSet<Place> Places { get; set; }
        public DbSet<Photo> Photos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Photo>()
                .Property(p => p.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Place>()
                .Property(p => p.Id)
                .ValueGeneratedOnAdd();

            modelBuilder.Entity<Place>()
                .HasMany(e => e.Photos)
                .WithOne(e => e.Place)
                .HasForeignKey(e => e.PlaceId)
                .HasPrincipalKey(e => e.Id)
                .OnDelete(DeleteBehavior.Cascade);
    }
}
