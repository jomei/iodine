/*
copyright: Boaz segev, 2016
license: MIT

Feel free to copy, use and enjoy according to the license provided.
*/
#ifndef IODINE_WEBSOCKETS_H
#define IODINE_WEBSOCKETS_H

#include "websockets.h"
#include <ruby.h>

void iodine_websocket_upgrade(struct HttpRequest* request,
                              struct HttpResponse* response,
                              VALUE handler);

#endif /* IODINE_WEBSOCKETS_H */