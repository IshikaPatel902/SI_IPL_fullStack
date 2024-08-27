using System.Numerics;
using System.Text.RegularExpressions;
using IPL_CodeMarathon.Models;

namespace IPL_CodeMarathon.DAO
{
    public interface IIplDao
    {
        Task<int> InsertPlayer(Player p);
        Task<Player> GetPlayerById(int id);
        Task<List<MatchStatistic>> GetMatchStatistics();

        Task<List<PlayerStatistic>> GetTopPlayersByFanEngagement();

       Task<List<Matchh>> GetMatchesByDateRange(DateTime startDate, DateTime endDate);

    }
}

