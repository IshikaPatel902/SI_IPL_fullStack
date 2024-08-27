import "../CSS/Navbar.css"
import { Link } from "react-router-dom"

const Navbar=()=>{
    return <>
    
    <nav>
        <a href="/"><h1>IPL Marathon</h1></a>
        <li>
            <Link to='/addplayer'>Add Player</Link>
        </li>
        <li>
        <Link to='/matchstatistic'>Match Statistic</Link>
        </li>
        <li>
        <Link to='/topplayer'>Top Players</Link>
        </li>
        <li>
        <Link to='/matchbyrange'>Match Details</Link>
        </li>
    </nav>
    
    </>
}

export default Navbar