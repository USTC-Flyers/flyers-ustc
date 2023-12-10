import request from "@/utils/request";

export function listPost(params) {
    return request({
        url: "/discussion/post/",
        method: "get",
        params,
    });
}

export function getPost(id) {
    return request({
        url: `/discussion/post/${id}`,
        method: "get",
    });
}

export function createPost(data) {
    return request({
        url: "/discussion/post/",
        method: "post",
        data,
    });
}
export function updatePost(id,data) {
    return request({
        url: `/discussion/post/${id}/`,
        method: "put",
        data,
    });
}

export function uploadImg(params) {
    return request({
        url: "/discussion/post/upload_img/",
        method: "get",
        params,
    });
}

export function postAction(id,data) {
    return request({
        url: `/discussion/post/${id}/action/`,
        method: "patch",
        data
    });
}
export function deletePost(id) {
    return request({
        url: `/discussion/post/${id}/`,
        method: "delete",
    });
}

export function comment(data) {
    return request({
        url: `/discussion/comment/`,
        method: "post",
        data
    })
}
export function listComment(params) {
    return request({
        url: "/discussion/comment/",
        method: "get",
        params,
    });
}
export function commentAction(id,data) {
    return request({
        url: `/discussion/comment/${id}/action/`,
        method: "patch",
        data
    });
}