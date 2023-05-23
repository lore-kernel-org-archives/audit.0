Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76357C7EE26
	for <audit@archiver.kernel.org>; Tue, 23 May 2023 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbjEWVu7 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 23 May 2023 17:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjEWVu6 (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 23 May 2023 17:50:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419EE5A
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:50:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30789a4c537so20065f8f.0
        for <audit@vger.kernel.org>; Tue, 23 May 2023 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684878639; x=1687470639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J6tMHyvFrOcwG0jlhJO8dd6aDQxsBeyHtoQoAF3lB8=;
        b=mzhpbjdw1OSIUhqFFtQGUP/6Jyij6fJOYZ32o2BNK8tezWHzLOxA7m856Zib1HkW86
         RcbBSwkYCL6gg54LGBF4jnz8aa61CtX17MvQi3tV3oigRpmosKghef2D3QGkW8hA6XKO
         zF1WRY8NOMmtZ2nF+8WZZ25zJ0rzL1dH32Nk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878639; x=1687470639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J6tMHyvFrOcwG0jlhJO8dd6aDQxsBeyHtoQoAF3lB8=;
        b=IKwfWFk+F1viTd1jaYW5wku08nlFNhJxhwwH1FC/U+T75kqf5J06QP+19EBr/jWP1R
         ezrL2yuBNY8rIIEGqxw9vQWgcApj1yZZO46XbT1ma+RylHg4YMRnm6EqOIJtDLApUhfJ
         XT+D3FADtIxEINb33uraCyIbSmZBJh4Jkj7GH6RMVJre4atjlu5hyKiC6hb8nIa4cbja
         W69A3gyCZjhD5Cfto+RGZ6cN/ro7dwSCmBCrRJuNdZinYKFijdd6/uCWKWGnQaNM8aOU
         7kze5mqlrvNeY1oW71rQwASpo6eVTYmRAzOD5e9obLGty/FpNG9r/HnO9yXZmCHmDdaj
         fjRg==
X-Gm-Message-State: AC+VfDz6s/IaojfzLmx3qOsyNJdVzCUG8SPOlBHEF9oSvee/5YaJDmhu
        3jsDxwLSjr9P09rwWZPA8coFAaxItg07D4pTgOcwJsuUYTs7zQcz9J4=
X-Google-Smtp-Source: ACHHUZ77ktq2SZqtw0VOQD9K5mXATk8+8O9mStErD1qNFrmPGlSLofDwqDj1JpXjweKSZfnTpsQ7WVrhfRXOS4B83QM=
X-Received: by 2002:a5d:43cb:0:b0:306:2c39:5d52 with SMTP id
 v11-20020a5d43cb000000b003062c395d52mr11022072wrr.57.1684878639084; Tue, 23
 May 2023 14:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 23 May 2023 14:50:27 -0700
Message-ID: <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Tue, May 23, 2023 at 12:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> Before seriously considering something like this, I would really like
> to see some time put into profiling the original overhead and some
> designs on how that could be improved.  Without that, patches like
> this look like drive-by band-aids which have already caused enough
> headaches for audit maintenance.

Hello Paul,

Could you elaborate on what exactly you would like to see added? It's
not clear to me what is missing.

There's a benchmark in the commit description with the numbers
attached, which quantifies and explains the existing overhead. In my
experience, people on Linux mailing lists frown upon external links to
images, but if it helps to visualize the effects, I have some
flamegraphs for the benchmark from the commit message:

* 10 rules, before:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-before.svg?s=3Daud=
it
* 10 rules, with patch applied:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after.svg?s=3Daudi=
t

Here's a couple extra:

* 0 rules, auditd running:
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after.svg?s=3Daudi=
t
* 11 rules (extra rule matching the running syscalls):
https://r2.ivan.computer/audit-syscall-bitmap/flamegraph-after-match.svg?s=
=3Daudit

The bitmap design mirrors what tracepoints implement for syscall entry/exit=
:

* https://elixir.bootlin.com/linux/v6.4-rc1/source/kernel/trace/trace_sysca=
lls.c#L585

I am happy to consider a different design if you have one in mind.
