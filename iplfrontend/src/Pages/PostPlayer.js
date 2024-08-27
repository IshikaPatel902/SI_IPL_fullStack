import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { addPlayer } from "../Services/apiService";
import "../CSS/PostForm.css"
import Navbar from "./Navbar";

const PostPlayer=()=>{

    const [player, setPlayer] = new useState({playerId:0, playerName:'', teamId:0, role:'', age:0, matchesPlayed: 0})
    const [loading,setLoading]=useState(true)
    const [error,setError]=useState(null)
    const navigate = useNavigate();
   
    const onChange = (e) => {
        setPlayer({...player, [e.target.id] : e.target.value})
    }


    const createPlayer = async () => {
        try {
            setLoading(true);
            const response = await addPlayer(player);
            if (response.error) {
                throw new Error(response.error.message);
            }
            setLoading(false);
            console.log('Added the player : ' + response);
            navigate('/');  
        } catch (error) {
            setLoading(false);
            setError(error);
        }
    };
    const validate = (e) => {
        e.preventDefault();

        if(player.playerId==='')    alert("Id is Mandatory")
        else if (player.playerName==='')    alert("Name is Mandatory")
        else if (player.teamId==='')    alert("Team Id is Mandatory")
        else if (player.role==='')    alert("Role is Mandatory")
        else if (player.age==='')    alert("Age is Mandatory")
        else if (player.matchesPlayed==='')    alert("Matches Played is Mandatory")
        else {
            console.log("Form submitted");
            createPlayer();
    }

        
    }


    if(loading) {<h1>Loading</h1>}
    if(error) {<h1>{error.message}</h1>}
    return <>
        <Navbar/>
        <h1>Add a new Player</h1>
        <form className='form-group' onSubmit={validate}>
        <div>
                Id : <input className='form-control' value={player.playerId} onChange={onChange} type='text' id='playerId' />
            </div>
            <div>
                Name : <input className='form-control' value={player.playerName} onChange={onChange} type='text' id='playerName' />
            </div>
            <div>
                Team Id : <input className='form-control' value={player.teamId} onChange={onChange} type='number' id='teamId'/>
            </div>
            <div>
                Role : <input className='form-control' value={player.role} onChange={onChange} type='text' id='role'/>
            </div>
            <div>
                Age : <input className='form-control' value={player.age} onChange={onChange} type='number' id='age' />
            </div>
            <div>
                Matches Played : <input className='form-control' value={player.matchesPlayed} onChange={onChange} type='number' id='matchesPlayed'  />
            </div>
            <button className='btn btn-primary m-2 p-3' type='submit'>Add new Player</button>
        </form>
    </>

}

export default PostPlayer;