import { useState, useEffect } from 'react'

export const useFetch = (url) => {

    const [isLoading, setLoading] = useState(true);
    const [data, setData] = useState({});
    const [error, setError] = useState(false);

    useEffect(() => {
        if (!url) return

        setLoading(true);

        async function fetchData() {
            
            try {
                const response = await fetch(url)
                if (! response.ok) {
                    const { errorMessage } = await response.json() 
                    throw new Error(errorMessage)
                } else {
                    const data = await response.json();
                    setData(data)
                }
            } catch(error) {
                setError(error.message)
            } finally {                
                setLoading(false);
            }
        }
        
        fetchData()
    }, [url])

    return {isLoading, data, error};
}