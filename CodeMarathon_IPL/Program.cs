using Npgsql;
using IPL_CodeMarathon.DAO;
using IPL_CodeMarathon.Controllers;
using Newtonsoft.Json;
using IPL_CodeMarathon.DAO;
namespace IPL_CodeMarathon
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var connectionString = builder.Configuration.GetConnectionString("PostgreDB");
            builder.Services.AddScoped((provider) => new NpgsqlConnection(connectionString));

            // Add services to the container.
            builder.Services.AddControllers();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddCors(options =>
            {
                options.AddPolicy("AllowAny", builder => builder.AllowAnyHeader().AllowAnyMethod().AllowAnyOrigin());
                options.AddPolicy("FrontEndClient", builder => builder.AllowAnyHeader().AllowAnyMethod().WithOrigins("https://localhost:3000"));
            });



            builder.Services.AddScoped<IIplDao, IplDaoImpl>();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseCors("AllowAny");
            app.UseCors("FrontEndClient");

            app.UseAuthorization();
            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
