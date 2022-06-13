
const putFile = () => {
    fetch('http://localhost:3000/game', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        //name: formData, // Use your own property name / key
      }),
    })
      .then((res) => res.json())
      .then((result) => console.log('hello world'))
      .catch((err) => console.log('error'))
}


function Put() {
    const upload = () => {

    }

    return (
        <div>
            <h1>Put file in the Sacem bucket</h1>
            <label className="btn btn-default">
                <input type="file"  />
            </label>
            <button
                className="btn btn-success"
                onClick={upload}
            >
                Upload
            </button>
        </div>)
}

export default Put;