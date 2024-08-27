import ipl from "../Image/ipl.jpg"
import Navbar from "./Navbar"
import '../CSS/Home.css'

const Home=()=>{
    return <>  
    <Navbar/>
    <img src={ipl} style={{ width: "70%"}} alt='IPL Image' />   
    </>
}

export default Home