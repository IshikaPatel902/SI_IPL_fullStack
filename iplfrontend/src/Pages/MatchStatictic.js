import { useState, useEffect } from "react"
import { GetMatchStatistic} from "../Services/apiService"
import "../CSS/MatchStatistic.css"
import Navbar from "./Navbar"

const MatchStatistic=()=>{

    const [data,setData]=useState([])
    const [loading,setLoading]=useState(true)
    const [error,setError]=useState(null)

    useEffect(()=>{
        const fetchData=async ()=>{
            const response= await GetMatchStatistic()
        setData(response.data)
        setLoading(response.loading)
        setError(response.error)
        }

        fetchData();
    },[])

    if(loading) return <p>Loading</p>
    if(error) return <p>Error: {error.message}</p>

    return <>
    <Navbar/>
    {data.length > 0 ? (
    <div>
        <h1>Match Statistic</h1>
        <table>
            <thead>
                <tr>
                    <th>Sr No.</th>
                    <th>Team 1</th>
                    <th>Team 2</th>
                    <th>Venue</th>
                    <th>Match Date</th>
                    <th>Total Fan Engagement</th>
                </tr>
            </thead>
            <tbody>
                {data.map((match, key) => (
                    <tr key={key}>
                        <td>{key+1}</td>
                        <td>{match.team1Name}</td>
                        <td>{match.team2Name}</td>
                        <td>{match.venue}</td>
                        <td>{match.matchDate}</td>
                        <td>{match.totalFanEngagement}</td>
                    </tr>
                ))}
            </tbody>
        </table>
    </div>
) : (
    <p>No stats available</p>
)}

    </>


}
export default MatchStatistic;