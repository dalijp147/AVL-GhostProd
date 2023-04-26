import axios from "axios";
axios.defaults.baseURL = '/';

axios.interceptors.response.use(resp => resp, async error => {
   
    if(error.response===Error.ERR_CONNECTION_REFUSED)
    {
        localStorage.clear();
        window.location.reload();
    }
   
    return error;
});
