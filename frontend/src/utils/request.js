import axios from "axios";
// import { Message } from "element-ui";
import store from "@/store";
import { getToken } from "@/utils/auth";

// create an axios instance
const service = axios.create({
  baseURL: "/api", // url = base url + request url
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 50000, // request timeout
});

// request interceptor
service.interceptors.request.use(
  (config) => {
    // do something before request is sent

    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      config.headers["Authorization"] = getToken();
      // console.log(getToken());
    }
    return config;
  },
  (error) => {
    // do something with request error
    console.log(error); // for debug
    return Promise.reject(error);
  }
);

// response interceptor
service.interceptors.response.use(
  /**
   * If you want to get http information such as headers or status
   * Please return  response => response
   */

  /**
   * Determine the request status by custom code
   * Here is just an example
   * You can also judge the status by HTTP Status Code
   */
  (response) => {
    return response.data;
  },
  (error) => {
    //console.log("err" + error); // for debug
    if (error.response.status === 401) {
      const hasToken = getToken();
      if (hasToken) {
        // refresh token
        store
          .dispatch("user/refreshToken")
          .then(() => {
            // console.log('refresh done')
          })
          .catch((error) => {
            console.log(error);
            return Promise.resolve(error);
          });
      }
    }
    return Promise.reject(error);
  }
);

export default service;
