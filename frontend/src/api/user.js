import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/login/',
    method: 'post',
    data
  })
}

export function getInfo() {
  return request({
    url: '/user_profile/user_detail/',
    method: 'get',
    // params: { token }
  })
}

export function update_contact(id, data) {
  return request({
    url: `/user_profile/${id}/`,
    method: 'patch',
    data
})
}
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}

