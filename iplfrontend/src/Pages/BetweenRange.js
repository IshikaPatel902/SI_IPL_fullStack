import { useState } from 'react';
import { GetMatchesByDateRange } from '../Services/apiService';
import '../CSS/BetweenRange.css'; 
import Navbar from './Navbar';

const BetweenRange = () => {
    const [matches, setMatches] = useState([]);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [startDate, setStartDate] = useState('');
    const [endDate, setEndDate] = useState('');
    const [submit, setSubmit] = useState(false);

    const fetchMatches = async () => {
        try {
            setLoading(true);
            const response = await GetMatchesByDateRange(startDate, endDate);
            setMatches(response.data);
            setLoading(false);
            setSubmit(true);
            setStartDate('');
            setEndDate('');
        } catch (err) {
            setError(err);
            setLoading(false);
        }
    };

    const handleSubmit = () => {
        if (startDate === '' || endDate === '') {
            alert("Both dates are required.");
        } else {
            fetchMatches();
        }
    };

    if (loading) return <p className="loading">Loading...</p>;
    if (error) return <p className="error">Error: {error.message}</p>;

    return (
        <><Navbar/>
        <div className="container">
            <input
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                type="text"
                id="startDate"
                placeholder="Enter Start Date"
            />
            <input
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                type="text"
                id="endDate"
                placeholder="Enter End Date"
            />
            <button onClick={handleSubmit} type="button">Enter</button>

            {submit ? (
                <div>
                    <h1>Match Statistics</h1>
                    {matches.length > 0 ? (
                        <table className="table">
                            <thead>
                                <tr>
                                    <th>Match Id</th>
                                    <th>Match Date</th>
                                    <th>Venue</th>
                                    <th>Team 1</th>
                                    <th>Team 2</th>
                                    <th>Winner</th>
                                </tr>
                            </thead>
                            <tbody>
                                {matches.map((match, index) => (
                                    <tr key={index}>
                                        <td>{match.matchId}</td>
                                        <td>{match.matchDate}</td>
                                        <td>{match.venue}</td>
                                        <td>{match.team1Name}</td>
                                        <td>{match.team2Name}</td>
                                        <td>{match.winnerTeamName}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    ) : (
                        <p>No matches found for the selected date range.</p>
                    )}
                </div>
            ) : (
                <p>Data will be displayed here..</p>
            )}
        </div>
        </>
    );
};

export default BetweenRange;