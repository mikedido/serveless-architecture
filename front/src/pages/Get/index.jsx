import { useFetch } from "../../utils/hooks";

function Get() {
    const { data, isLoading, error } = useFetch(`https://dgddt5wp1l.execute-api.us-east-1.amazonaws.com/api/files`);

    if (error) {
        return <div>{error}</div>
    }

    return (
        <div>
            <h1>Get files from the Sacem bucket</h1>
            <div>
                <div>Number of files : </div>
                <div>La liste des fichiers</div>
                {isLoading ?
                (
                    <div>En cours de chargement</div>
                )
                :(
                    data.map((key) => (
                        <div> name : {key}</div>
                    ))
                )
                }
            </div>
        </div>)
}

export default Get;