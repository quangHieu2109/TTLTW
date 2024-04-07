
async function _getFeeship(provinceID, districtID, wardID,quantity,weight,length,width,height,unitship) {
    let url = "province="+provinceID+"&district="+districtID+"&ward="+wardID+"&quantity="+quantity+"&weight="+weight+"&length="+length+"&width="+width+"&height="+height+"&unitShip="+unitship;
    const response = await fetch(contextPathMetaTag.content + "/feeship?"+url, {
        method: "GET",
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
        },
    });
    return [response.status, await response.json()];
}
var unit_ship;
let unitshipVal;

document.addEventListener('DOMContentLoaded', async function () {

    unitshipVal= document.getElementById("unit-ship").value;
    unit_ship= document.getElementById("unit-ship");
    unit_ship.addEventListener("change", async function () {

            let province = document.getElementById("selectProvince").value;
            let district = document.getElementById("selectDistrict").value;
            let ward = document.getElementById("selectWard").value;
            let unitshipVal = document.getElementById("unit-ship").value;
            if (unitshipVal == "ViettelPost") {
                unitshipVal=1;
            }else {
                unitshipVal=0;
            }
            // let quantity = document.getElementById("quantity").value;
            // let weight = document.getElementById("weight").value;
            // let length = document.getElementById("length").value;
            // let width = document.getElementById("width").value;
            // let height = document.getElementById("height").value;

        //fake data
        let quantity = 1;
        let weight = 100;
        let length = 10;
        let width =20;
        let height = 2;

            let [status, data] = await _getFeeship(province, district, ward, quantity, weight, length, width, height, unitshipVal);
            if (status === 200) {
                data = data.infoShips;
                let s='';
                data.forEach(function (dt) {
                    s+='<div class="form-label"> <input type="radio" name="infoship" class="m-2">'+dt.TEN_DICHVU+' Giá: '+dt.GIA_CUOC+' '+dt.THOI_GIAN+'</div>';
                });

                document.getElementById("infoShip").innerHTML = s;

            }

        }
    );

});
export default _getFeeship;