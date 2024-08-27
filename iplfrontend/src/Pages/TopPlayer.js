import { useState, useEffect } from "react"
import { GetTopPlayer } from "../Services/apiService"
import "../CSS/TopPlayer.css"
import Navbar from "./Navbar"

const TopPlayer=()=>{

    const [data,setData]=useState([])
    const [loading,setLoading]=useState(true)
    const [error,setError]=useState(null)

    useEffect(()=>{
        const fetchData=async ()=>{
            const response= await GetTopPlayer()
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
        <h1>Top 5 Player</h1>
                {data.map((player, key) => (
                    <div key={key}>
                    <ul>
                        <li>Player Id: {player.playerId}</li>
                        <li>Player Name: {player.playerName}</li>
                        <li>Matches Played: {player.matchesPlayed}</li>
                        <li>Total Fan Engagement: {player.totalFanEngagement}</li>
                    </ul>
                    </div>
                ))}      
    </div>
) : (
    <p>No stats available</p>
)}
    </>
}
export default TopPlayer;