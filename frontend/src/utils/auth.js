import Cookies from "js-cookie";

const TokenKey = "flyers_token";
const RefreshTokenKey = "flyers_refresh_token";

export function getToken() {
  return Cookies.get(TokenKey);
}

export function getRefresh() {
  return Cookies.get(RefreshTokenKey);
}

export function setToken(token) {
  return Cookies.set(TokenKey, token);
}

export function setRefresh(token) {
  return Cookies.set(RefreshTokenKey, token);
}

export function removeToken() {
  return Cookies.remove(TokenKey);
}

export function removeRefresh() {
  return Cookies.remove(RefreshTokenKey);
}
