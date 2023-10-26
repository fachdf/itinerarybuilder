using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ItineraryBuilder_Backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdatePlaceTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "GoogleMapUrl",
                table: "Places",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "GoogleMapUrl",
                table: "Places");
        }
    }
}
