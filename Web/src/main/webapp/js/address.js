const contextPathMetaTag = document.querySelector("meta[name='contextPath']");
const currentUserIdMetaTag = document.querySelector("meta[name='currentUserId']");
var province;
var district;
var ward;

async function _getProvice() {
    const response = await fetch(contextPathMetaTag.content + "/address", {
        method: "GET",
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
        },
    });

    return [response.status, await response.json()];
}

async function _getDistrictByProvince(name) {
    const response = await fetch(contextPathMetaTag.content + "/address?provinceName=" + name, {
        method: "GET",
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
        },
    });
    return [response.status, await response.json()];
}

async function _getWardByDistrict(name) {
    const response = await fetch(contextPathMetaTag.content + "/address?districtName=" + name, {
        method: "GET",
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
        },
    });
    return [response.status, await response.json()];
}

async function _getUserAddress() {
    const response = await fetch(contextPathMetaTag.content + "/userAddress", {
        method: "GET",
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
        },
    });
    return [response.status, await response];
}

document.addEventListener('DOMContentLoaded', async function () {

    // var selectProvince = document.getElementById('selectProvince');
    // async function getAddressData() {
    //     try {
    //         const [status, data] = await _getUserAddress();
    //         if (status === 200) {
    //             for(var value in data){
    //                 data[value].forEach(function (dt){
    //                     let option = '<option value="'+dt.province.name+'-'+ dt.district.name
    //                         +'-'+ dt.ward.name +'</option>';
    //                     selectProvince.innerHTML += option;
    //                     console.log(option)
    //                 })
    //             }
    //         } else {
    //             console.log("Yêu cầu không thành công. Mã trạng thái: " + status);
    //         }
    //     } catch (error) {
    //         console.log("Đã xảy ra lỗi:", error);
    //     }
    // }

    district = document.getElementById("selectDistrict");
    ward = document.getElementById("selectWard");
    province = document.getElementById("selectProvince");
    province.addEventListener("change", async function () {

        // Lấy phần tử option được chọn
        let selectedOption = province.options[province.selectedIndex];
        // Lấy giá trị của option được chọn
        let selectedValue = selectedOption.value;
        // In giá trị ra console hoặc thực hiện các thao tác khác
        await selectDistrict();
        selectWard()
    });
    district.addEventListener("change", function () {

        // Lấy phần tử option được chọn
        let selectedOption = district.options[district.selectedIndex];
        // Lấy giá trị của option được chọn
        let selectedValue = selectedOption.value;
        // In giá trị ra console hoặc thực hiện các thao tác khác
        selectWard();
    });
    // getAddressData();
    await selectProvince();
    await selectDistrict();
    await selectWard()
});

async function selectDistrict() {
    await _getDistrictByProvince(document.getElementById('selectProvince').value).then(([status, data]) => {
            if (status === 200) {


                // Thêm option mới vào trong select

                data = data.districts;
                let option = '<option value="none">Chọn quận/huyện</option>';
                data.forEach(function (dt) {
                    if (dt.DISTRICT_NAME == document.getElementById('selectDistrict').value) {

                        option += '<option selected value="' + dt.DISTRICT_NAME + '">' + dt.DISTRICT_NAME + '</option>';
                    } else {
                        option += '<option value="' + dt.DISTRICT_NAME + '">' + dt.DISTRICT_NAME + '</option>';
                    }

                });
                district.innerHTML = option;
            }
        }
    )
}

async function selectProvince() {
    await _getProvice().then(([status, data]) => {
            if (status === 200) {


                data = data.provinces;

                // Thêm option mới vào trong select
                let option = '<option value="none">Chọn tỉnh/thành phố</option>';


                data.forEach(function (dt) {
                    if (dt.PROVINCE_NAME == document.getElementById('selectProvince').value) {
                        option += '<option selected value="' + dt.PROVINCE_NAME + '">' + dt.PROVINCE_NAME + '</option>';
                    } else {
                        option += '<option value="' + dt.PROVINCE_NAME + '">' + dt.PROVINCE_NAME + '</option>';
                    }


                    // Thêm option mới vào trong select
                });
                province.innerHTML = option;
            }
        }
    )
}

async function selectWard() {
    await _getWardByDistrict(document.getElementById("selectDistrict").value).then(([status, data]) => {
            if (status === 200) {


                data = data.wards;

                // Thêm option mới vào trong select
                let option = '<option value="none">Chọn phường/xã</option>';
                data.forEach(function (dt) {
                    if (dt.WARDS_NAME == document.getElementById('selectWard').value) {
                        option += '<option selected value="' + dt.WARDS_NAME + '">' + dt.WARDS_NAME + '</option>';
                    } else {
                        option += '<option value="' + dt.WARDS_NAME + '">' + dt.WARDS_NAME + '</option>';
                    }

                });
                ward.innerHTML = option;
            }
        }
    )
}
