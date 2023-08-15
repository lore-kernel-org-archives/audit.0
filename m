Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A5C41513
	for <audit@archiver.kernel.org>; Tue, 15 Aug 2023 22:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbjHOWQi (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbjHOWQP (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 15 Aug 2023 18:16:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E3198C
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d5352bdb0so204029885a.0
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137774; x=1692742574;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qv6BJq2VuOIBKm2R5SQfyXniDVD4bBxdFB+ZKjbHdTY=;
        b=LVd86Uah0lEj1PtGQRA63Mar2+vnyaBCMLo95m7G2a80hYPIM6F8hCe/XBEQD5uP0A
         omkGtYBrLHda4rr7P3hWHsO/VkYlB+IPkAL3gmC216Q3KaTmkt0wKZBbBRgwNmyh7Qwd
         xUQjLaKsc+rDzFgpTh2z8NuKvZbxQcGknhTHJVMCwaLZlAy21NPQXE+r+1pPng/NnL4y
         XPmEUOyctuLQBSmjuZt3F6xBH/PQ72VZNBgf3YnOMqHGi75aZqBf+XkcVCptvq9N9qe9
         c8VM4W3GFWUkxZAVnRdizQS+7Hm62vT++HD/9C6mkVaratGy6cyESuSAyLgc+74cqaeb
         b1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137774; x=1692742574;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv6BJq2VuOIBKm2R5SQfyXniDVD4bBxdFB+ZKjbHdTY=;
        b=TC1SVBQhKwD6HLU/RHWMcagtq7Y8ak0S7wDqngN3iKz+qX6JxtTQn7L6+v4B5/iWWK
         qtEIEG4HU56cpZhncSwDq6wqllGR+GBPYxJSqAe2uiREw/iT0hmU4OqMb4sfzqpI/ney
         pKB6deN/5SnjF5/3QL6oOyBop26Gc0yeY9LCpdK401LBufPGh0HnAbwlJHIJaWi4Whk6
         W+pxtbO/WMMz5jkI9IvTBrXgdvQzwCxCEN7yMDy6NUevCkltqUvTU/kZBukYuoAN8F9J
         uB6ufIdkJZts8GHeB/TMdJCQgJ33QKNDJqUO8amHWGbvGLDQdvIJhTeN7YPWoezg0sgY
         9yEw==
X-Gm-Message-State: AOJu0YxtCL9BgmPlH+Ez62jewyK/OVTHweuJfWwf0yGYX1G1Q19+tXpc
        1LnLM+BAJu1oItzh1+UHSqlv
X-Google-Smtp-Source: AGHT+IHwX9/8dy3LUKS5wQU3/+IHRSlM6nubbbJWfnEyOGWPp/bSlpdyUzvrF6Itvv41IIqXUk62hg==
X-Received: by 2002:a05:620a:4d9:b0:76c:c636:4772 with SMTP id 25-20020a05620a04d900b0076cc6364772mr179079qks.65.1692137774065;
        Tue, 15 Aug 2023 15:16:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o13-20020ae9f50d000000b00767cd764ecfsm4060074qkg.33.2023.08.15.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:16:13 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:16:13 -0400
Message-ID: <2d9f6af1443608a4e5ccfffb0ae15e14.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: Moves trailing statements to next line
References: <20230815204751.52481-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204751.52481-1-atulpant.linux@gmail.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> Fixes following checkpatch.pl issue:
> ERROR: trailing statements should be on next line
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/audit.c       | 3 ++-
>  kernel/auditfilter.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Changed the subject line to "audit: move trailing statements to next
line", otherwise it looked fine.  Merged into audit/next.

--
paul-moore.com
