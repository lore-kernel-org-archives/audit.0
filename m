Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C824C7EE23
	for <audit@archiver.kernel.org>; Wed, 24 May 2023 02:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbjEXCDu (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 23 May 2023 22:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbjEXCDu (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 23 May 2023 22:03:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41213E
        for <audit@vger.kernel.org>; Tue, 23 May 2023 19:03:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba8afcc82c0so863677276.2
        for <audit@vger.kernel.org>; Tue, 23 May 2023 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684893828; x=1687485828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOon+WJOJI8+JwO5uO9f8iJb1ORFwlHFloJ3UvTpfgc=;
        b=UFEAXGWkCrWSSfXmpcK4Hs6xsXEnrzSBJxTqWM4F7szWa9/aDVp1VjCZ+UKcK+xoHM
         PmAOLGT5LfEuMIEKnBZ4wabefUZ+LVmIUFHWn5xPd/bykUkGQPp9j+LZxAlUxONq5uk7
         yRSm5vIBLRm+wpD08KvTiIaL4QxV9z3DUzne98cb8hqRzh8ZjvRvYreYH6IzQBrEz9eu
         2UY4MdNfRRyWRFSHaJzQdppmy0L4PtosL8GWXlVCnaPSeXr+e1FJhuwhAiy12y8ENowQ
         39b1yiQnYgOliG3KAI1y99BlfHwmgGwiStE3PaSK8nM90UWnO9Pg2d6fCU5FbkcPbjrL
         8vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684893828; x=1687485828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOon+WJOJI8+JwO5uO9f8iJb1ORFwlHFloJ3UvTpfgc=;
        b=jLI5dF3pOgwhJpxzL+0LLF57E6E5Og7jK3QAu+al8sFZCGXBaNc9ZdzqkBvHVpIomI
         k++WnvheushEtNe/ptnMB1tMQX7Xued1F+/u0ZPPzocytmKQkDtPvHskTb4zN1PyMe9g
         bdVL/bfZde9IUQ8oY7MX2ytCkDu1xQ2BJ9wkW7YAj4K8uMJjGmEPmgiFvqLP2XgSnPCK
         YtlNMZOY4G9Av0xXKedkrKrctoYPiwqR+x03HuCnJxKsUgiS9g4qPlUbzUiX9+mAOf+k
         7n2UlXTerKmA71u2zejrRrTZ2Ra8/Ro1zse1cQ0nT/FJ0yU+O+mm7PKnwWk4B6WgFBde
         Xbtg==
X-Gm-Message-State: AC+VfDzwXFshxd2m8sgnxbeuq7nRT2790DEQ6rjp4OxApxenGOVsqE0N
        1iDruGD+fzN7OU/pCmE2gft3Pe12m4Q7phcEYM/X
X-Google-Smtp-Source: ACHHUZ7gejpbuXJwcXtecq2tYyFg25U/Vh6AH2Ix5ntTdGeydgt5znEovV4qhhLIpcEdd+FNyhP4IJNOMr/SKEzPnpg=
X-Received: by 2002:a25:b120:0:b0:ba6:f32b:28e3 with SMTP id
 g32-20020a25b120000000b00ba6f32b28e3mr17242402ybj.6.1684893827701; Tue, 23
 May 2023 19:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
In-Reply-To: <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 22:03:36 -0400
Message-ID: <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, May 23, 2023 at 5:50=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> On Tue, May 23, 2023 at 12:59=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > Before seriously considering something like this, I would really like
> > to see some time put into profiling the original overhead and some
> > designs on how that could be improved.  Without that, patches like
> > this look like drive-by band-aids which have already caused enough
> > headaches for audit maintenance.
>
> Hello Paul,
>
> Could you elaborate on what exactly you would like to see added? It's
> not clear to me what is missing.

I should have been more clear, let me try again ...

From my perspective, this patch adds code and complexity to deal with
the performance impact of auditing.  In some cases that is the right
thing to do, but I would much rather see a more in-depth analysis of
where the audit hot spots are in this benchmark, and some thoughts on
how we might improve that.  In other words, don't just add additional
processing to bypass (slower, more involved) processing; look at the
processing that is currently being done and see if you can find a way
to make it faster.  It will likely take longer, but the results will
be much more useful.

Does that make sense?

--=20
paul-moore.com
