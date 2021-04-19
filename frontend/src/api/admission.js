import request from '@/utils/request'

export function background_create(data) {
  return request({
    url: '/background/',
    method: 'post',
    data
  })
}

export function background_get_my() {
  return request({
    url: '/background/user_detail/',
    method: 'get',
    // params: {  }
  })
}

export function background_get_user(user_id) {
    return request({
      url: '/background/user_detail/',
      method: 'get',
      params: { pk: user_id }
    })
}

export function background_submit(data) {
    return request({
      url: '/background/',
      method: 'post',
      data
    })
  }

export function background_update(id, data) {
    return request({
      url: `/background/${id}/`,
      method: 'put',
      data
    })
  }
// export function getInfo(token) {
//   return request({
//     url: '/info/',
//     method: 'get',
//     params: { token }
//   })
// }

// export function logout() {
//   return request({
//     url: '/logout',
//     method: 'post'
//   })
// }