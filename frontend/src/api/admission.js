import request from '@/utils/request'

export function admissions_get_all() {
    return request({
        url: '/admissions/',
        method: 'get',
    })
}

export function admissions_get_my() {
    return request({
        url: '/admissions/user_detail/',
        method: 'get',
    })
}

export function university_query(query_string) {
    return request({
        url: '/university/',
        method: 'get',
        params: { query: query_string }
    })
}

export function programs_get(univ_id) {
    return request({
        url: '/program/',
        method: 'get',
        params: { uid: univ_id }
    })
}

export function admissions_create(data) {
    return request({
        url: '/admissions/',
        method: 'post',
        data
    })
}

export function admissions_update(id, data) {
    return request({
        url: `/admissions/${id}/`,
        method: 'put',
        data
    })
}

export function admissions_delete(id) {
    return request({
        url: `/admissions/${id}/`,
        method: 'delete',
    })
}
