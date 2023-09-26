Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CDE7F143
	for <audit@archiver.kernel.org>; Tue, 26 Sep 2023 22:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIZWny (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjIZWlx (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 26 Sep 2023 18:41:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FA59EF0
        for <audit@vger.kernel.org>; Tue, 26 Sep 2023 14:27:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d8195078f69so10618655276.3
        for <audit@vger.kernel.org>; Tue, 26 Sep 2023 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763678; x=1696368478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwboT3wS2a1yBHjDCQ06HZTwGyv2f0/zi3F8PPJditg=;
        b=Wdre1CXgUDxix66xbAJwHumLtH5lJzKK2jXd5RbWQ675ewAWebuohkoN7zjPXM33Ml
         Ulfn4SUZcBrr0pbjeCbMKYuEED/316rqwSUW/ETFPlntJf6xixDanBNV6LR8xKdVgMps
         T5E/HU1vcD0m4o70Lk/EvISFAaPuQT3W7h1zosuJBspdjIdWWbfeoKqgPXgFcud+aKSr
         DVuVZsDDvF18D/roYVkg04TxNpqc7XnDl/8WbLQhpUYnonMWXZmNJDmB20QASw//coY4
         WCtE6+K/TCotAAgsF585JnF1hXv9TXantyFcuusBd9D7nzvCxNhe9xfD0DzPLIYlYU10
         Iztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763678; x=1696368478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwboT3wS2a1yBHjDCQ06HZTwGyv2f0/zi3F8PPJditg=;
        b=QKlomWVTBBbHJQgVjEdhzpvo5bfTe3GzENBPwrguMj44Id3naOrvohRaVtGhsVbm5T
         dzylukKpeeHvgpFD8A0MuCzNCyH10ym2J8AUROo4LxE9c1KIUes8ZkHobrmgHy+DRDba
         mMGdSuhvbPQcIBST5GZG5QZLVRQJeUEG57vFcQlwH5xdQjcccFGLO9W08AgvHQyfHgPp
         mThMkYprOoep7a0WO0ktWGzGQ8+bQvFmwRkBDgVGhfXcN8k5eCIWMXvMiaI/iGAGpB1r
         MX18TQx7m32cs4ZnKshsZUkxW+FzLHlHOVQ3g0by6AzLNNmNH2OZWiPTg6pg0fm2h8j5
         UH7A==
X-Gm-Message-State: AOJu0YwuBpcEXyLxxygM1v07em9A+EsxyuGtw5tbfBjXm3wsqOYrV9rP
        CDDR8PHUep0VRsMsDA7sgq+GCzX7BV9bCg2mSr5C
X-Google-Smtp-Source: AGHT+IGEOPatV9DMHgk6ahe+ZNCEftvet7jzAHqC188+LRWLJCUQ62hLSOHIPtTbwO1LBBLGz1+WP4Ij6RfoH/mqsaw=
X-Received: by 2002:a25:7611:0:b0:d81:7f38:6d64 with SMTP id
 r17-20020a257611000000b00d817f386d64mr133266ybc.4.1695763678663; Tue, 26 Sep
 2023 14:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230922152749.244197-1-chris.riches@nutanix.com>
In-Reply-To: <20230922152749.244197-1-chris.riches@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:27:47 -0400
Message-ID: <CAHC9VhQYFjRnmC3LTKkhXuKhvjGQG+dTXqL6ExXbNC9M2DZ3ZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Sep 22, 2023 at 11:28=E2=80=AFAM Chris Riches <chris.riches@nutanix=
.com> wrote:
>
> When auditd_set sets the auditd_conn pointer, audit messages can
> immediately be put on the socket by other kernel threads. If the backlog
> is large or the rate is high, this can immediately fill the socket
> buffer. If the audit daemon requested an ACK for this operation, a full
> socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
> socket.
>
> To avoid this race and ensure ACKs get through, fast-track the ACK in
> this specific case to ensure it is sent before auditd_conn is set.
>
> Signed-off-by: Chris Riches <chris.riches@nutanix.com>
>
> ---
>
> This mail is more of an RFC than a patch, though the included patch is a
> useful illustation and might even be suitable for inclusion ...

Hi Chris,

Thanks for the patch and the background information, that's always
helpful.  Unfortunately I have limited network access at the moment,
but I'll put this on my list to look at next week.

--=20
paul-moore.com
