import { BrowserRouter, Route, Routes } from "react-router-dom"
import Home from "../Pages/Home"
import PostPlayer from "../Pages/PostPlayer"
import MatchStatistic from "../Pages/MatchStatictic"
import TopPlayer from "../Pages/TopPlayer"
import BetweenRange from "../Pages/BetweenRange"


const RouterConfig =()=>{
    return <>
        <BrowserRouter>
        
        <Routes>
            <Route path="/" element={<Home/>}/>
            <Route path="/addplayer" element={<PostPlayer/>}/>
            <Route path="/matchstatistic" element={<MatchStatistic/>}/>
            <Route path="/topplayer" element={<TopPlayer/>}/>
            <Route path="/matchbyrange" element={<BetweenRange/>}/>

        </Routes>
        
        </BrowserRouter>
    </>
}

export default RouterConfig