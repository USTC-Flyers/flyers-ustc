import request from "@/utils/request";

export function login(ticket) {
  return request({
    url: "/login/",
    method: "get",
    params: { ticket },
  });
}

export function logout(token) {
  return request({
    url: "/logout/",
    method: "post",
    data: {
      "refresh_token": token
    }
  })
}

export function refresh(token) {
  return request({
    url: "/refresh/",
    method: "post",
    data: {
      "refresh": token
    }
  })
} 

export function getInfo() {
  return request({
    url: "/user_profile/user_detail/",
    method: "get",
    // params: { token }
  });
}
export function create_user_profile(data) {
  return request({
    url: "/user_profile/",
    method: "post",
    data,
  });
}
export function get_user_profile(user_id) {
  return request({
    url: "/user_profile/user_detail/",
    method: "get",
    params: { pk: user_id },
  });
}
export function update_user_profile(id, data) {
  return request({
    url: `/user_profile/${id}/`,
    method: "patch",
    data,
  });
}


export function initNotification() {
  return request({
    url: "/notification/unread_set/",
    method: "get",
  });
}

export function initNotificationCount() {
  return request({
    url: "/notification/unread_count/",
    method: "get",
  });
}

export function getNotification() {
  return request({
    url: "/notification/",
    method: "get",
  });
}

export function readNotification(id) {
  return request({
    url: `/notification/${id}/read/`,
    method: "post"
  })
}