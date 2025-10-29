-- Создай таблицы:
-- users (id, name, email, created_at)
-- posts (id, user_id, text, created_at)
-- comments (id, post_id, user_id, text, created_at)
-- likes (user_id, post_id)
--
-- Требования:
-- Один пользователь может писать посты и комментировать.
-- Один пользователь может лайкать один пост только один раз.
-- При удалении пользователя — удалить все его посты, комментарии и лайки.

create table users
(
    id         serial primary key,
    name       text      not null,
    email      text      not null unique,
    created_at timestamp not null
);

create table posts
(
    id         serial primary key,
    user_id    bigint    not null,
    text       text      not null,
    created_at timestamp not null,
    foreign key (user_id) references users (id) on delete cascade
);

create table comments
(
    id         serial primary key,
    post_id    bigint    not null,
    user_id    bigint    not null,
    text       text      not null,
    created_at timestamp not null,
    foreign key (post_id) references posts (id) on delete cascade,
    foreign key (user_id) references users (id) on delete cascade
);

create table likes
(
    user_id bigint not null,
    post_id bigint not null,
    primary key (user_id, post_id),
    foreign key (user_id) references users (id) on delete cascade,
    foreign key (post_id) references posts (id) on delete cascade
);
