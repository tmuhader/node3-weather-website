const forecast = require("../src/utils/forecast");

describe("API unit test suite",()=>{
    describe("get weather for Nantes", ()=>{
        forecast("Nantes")
            .then((response) => {
                console.log("inside then of app.js" + response);
                it("returns weather",()=>{
                    expect(response).toEqual(25);
                })

            })
    })
})