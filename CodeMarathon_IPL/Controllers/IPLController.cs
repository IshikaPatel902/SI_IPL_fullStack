using IPL_CodeMarathon.DAO;
using IPL_CodeMarathon.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace IPL_CodeMarathon.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class IPLController : ControllerBase
    {

        private readonly IIplDao _iplDao;

        public IPLController(IIplDao iplDao)
        {
            _iplDao = iplDao;
        }


        [HttpGet("{id:int}", Name = "GetPlayerById")]
        public async Task<ActionResult<Player?>> GetPlayerById(int id)
        {
            Player? player = await _iplDao.GetPlayerById(id);
            if (player == null)
            {
                return NotFound();
            }
            return Ok(player);
        }

        //Problem 1: Insert Player
        [HttpPost]
        public async Task<ActionResult<int>> InsertPlayer(Player p)
        {
            if (p != null)
            {
                if (ModelState.IsValid)
                {
                    int res = await _iplDao.InsertPlayer(p);
                    if (res > 0)
                    {
                        return CreatedAtRoute(nameof(GetPlayerById), new { id = p.PlayerId }, p);

                    }
                }
                return BadRequest("Failed to add product");

            }
            else
            {
                return BadRequest();
            }
        }

        //Problem 2: Match Statistic
        [HttpGet("MatchStatistic")]
        public async Task<ActionResult<List<MatchStatistic>>> GetMatchStatistics()
        {
            List<MatchStatistic> matchStatistic = await _iplDao.GetMatchStatistics();
            if (matchStatistic == null)
            {
                return NotFound();
            }
            return Ok(matchStatistic);
        }

        //Problem3: Top5Player
        [HttpGet("TopPlayer")]
        public async Task<ActionResult<List<PlayerStatistic>>> GetTopPlayerByFanEngagement()
        {
            List<PlayerStatistic> playerStatistic = await _iplDao.GetTopPlayersByFanEngagement();
            if (playerStatistic == null)
            {
                return NotFound();
            }
            return Ok(playerStatistic);
        }

        //Problem4: Match by start and end range
        [HttpGet("MatchByRange")]
        public async Task<IActionResult> GetMatchesByDateRange([FromQuery] DateTime startDate, [FromQuery] DateTime endDate)
        {
            var matches = await _iplDao.GetMatchesByDateRange(startDate, endDate);
            if (matches == null)
            {
                return NotFound();
            }
            return Ok(matches);
        }



    }
}




