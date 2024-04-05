document.addEventListener('DOMContentLoaded', function() {
    const contextPathMetaTag = document.querySelector("meta[name='contextPath']");
    const currentUserIdMetaTag = document.querySelector("meta[name='currentUserId']");

    async function _getProvice() {
        const response = await fetch(contextPathMetaTag.content + "/address" , {
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
        });
        return [response.status, await response.json()];
    }
    async function _getDistrictByProvince(id) {
        const response = await fetch(contextPathMetaTag.content + "/address?provinceID="+id , {
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
        });
        return [response.status, await response.json()];
    }
    async function _getWardByDistrict(id) {
        const response = await fetch(contextPathMetaTag.content + "/address?wardID="+id , {
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
        });
        return [response.status, await response.json()];
    }
    async function _getUserAddress(){
        const response = await fetch(contextPathMetaTag.content + "/userAddress" , {
            method: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
        });
        return [response.status, await response.json()];
    }
    var selectProvince = document.getElementById('selectProvince');
    async function getAddressData() {
        try {
            const [status, data] = await _getUserAddress();
            if (status === 200) {
                for(var value in data){
                    data[value].forEach(function (dt){
                        let option = '<option value="' +dt.id+ '">'+dt.province.name+'-'+ dt.district.name
                            +'-'+ dt.ward.name +'</option>';
                        selectProvince.innerHTML += option;
                        console.log(option)
                    })
                }
            } else {
                console.log("Yêu cầu không thành công. Mã trạng thái: " + status);
            }
        } catch (error) {
            console.log("Đã xảy ra lỗi:", error);
        }
    }

    getAddressData();

})