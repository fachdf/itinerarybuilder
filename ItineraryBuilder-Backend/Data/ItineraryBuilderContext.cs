using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ItineraryBuilder_Backend;
using ItineraryBuilder_Backend.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

public class ItineraryBuilderContext : IdentityDbContext
{
        public ItineraryBuilderContext (DbContextOptions<ItineraryBuilderContext> options)
            : base(options)
        {
            
        }

        public DbSet<Place> Places { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<Itinerary> Itinerary { get; set; }
        public DbSet<ItineraryPlace> ItineraryPlace { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder); 
/*        modelBuilder.Entity<IdentityUserLogin<string>>().HasNoKey();
        modelBuilder.Entity<IdentityUserToken<string>>().HasNoKey();
        modelBuilder.Entity<IdentityUserRole<string>>().HasNoKey();
        // modelBuilder.Ignore<ApplicationUser>();*/

        modelBuilder.Entity<Photo>()
                .Property(p => p.Id)
                .ValueGeneratedOnAdd();

        modelBuilder.Entity<Place>()
            .Property(p => p.Id)
            .ValueGeneratedOnAdd();

        modelBuilder.Entity<Itinerary>()
            .Property(p => p.Id)
            .ValueGeneratedOnAdd();

        modelBuilder.Entity<Place>()
                .HasMany(e => e.Photos)
                .WithOne(e => e.Place)
                .HasForeignKey(e => e.PlaceId)
                .HasPrincipalKey(e => e.Id)
                .OnDelete(DeleteBehavior.Cascade);

        modelBuilder.Entity<Itinerary>()
            .HasMany(i => i.ItineraryPlaces)
            .WithOne(ip => ip.Itinerary)
            .HasForeignKey(ip => ip.ItineraryId)
            .HasPrincipalKey(e => e.Id)
            .OnDelete(DeleteBehavior.Cascade)
            .IsRequired(false);

        modelBuilder.Entity<Place>()
            .HasMany(p => p.ItineraryPlaces)
            .WithOne(ip => ip.Place)
            .HasForeignKey(e => e.PlaceId)
            .HasPrincipalKey(e => e.Id)
            .OnDelete(DeleteBehavior.Cascade)
            .IsRequired(false);

        modelBuilder.Entity<ItineraryPlace>()
            .HasKey(x => new { x.ItineraryId, x.PlaceId });

        modelBuilder.Entity<ItineraryPlace>()
            .HasOne(ip => ip.Place)
            .WithMany(p => p.ItineraryPlaces)
            .HasForeignKey(ip => ip.PlaceId);

        modelBuilder.Entity<ItineraryPlace>()
            .HasOne(ip => ip.Itinerary)
            .WithMany(i => i.ItineraryPlaces)
            .HasForeignKey(ip => ip.ItineraryId);

        modelBuilder.Entity<Itinerary>()
            .HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(i => i.UserId);

        modelBuilder.Entity<Place>()
            .HasOne<IdentityUser>()
            .WithMany()
            .HasForeignKey(i => i.UserId);
    }
}
