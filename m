Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39AEB64DA
	for <audit@archiver.kernel.org>; Thu, 20 Jul 2023 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGTTGr (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGTTGr (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 20 Jul 2023 15:06:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63490E75
        for <audit@vger.kernel.org>; Thu, 20 Jul 2023 12:06:46 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b6b7c0f7so10397391cf.0
        for <audit@vger.kernel.org>; Thu, 20 Jul 2023 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689880005; x=1690484805;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B81lxhSSxJfeg3Zx00h9FlyCTOeh4jFpxk+LKRa9GBI=;
        b=MNCntd85m1MM0LW07BRxJhiU2rluyJHiH+JAN7XjwlUbakqvU0pxtHb4sRHJCMmdqQ
         poAN6Y5Uimqk9Kb6erxFXdq2RF3BjsYzKgUGXM9UAnOdtmnsJ3TGoJK+6g8+NTLvw1mF
         TCkqzgVGp218P2WInv9IfgHGLdD4OScu/lIzMokCL6MDGUz0DUK8fhom+t52V7mlKXjC
         Oc6l9dDAzJOZswshoPML6QKBr6BlNwdBKtIKukvDSBFjt0sYaq7iHe+aeHgjRnsJkxdv
         RHV5071vX148nzWhTynH3IPo8k89l4xRKE3t6p8Egvlgf2d0/To8OFVnGJqcvkWiAwtC
         OC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880005; x=1690484805;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B81lxhSSxJfeg3Zx00h9FlyCTOeh4jFpxk+LKRa9GBI=;
        b=EwWV7ETD7vvEsAR8D44vDu1WgYX3DhKHsEyvNqSrCUMEKAjERK/D9dV85i/Y32ljFj
         eNsHVeryLPlkHLsTzpuDBS0KDeJJnyIcIAyKvI+pF2dH202MghBUCrll9qIOCoEY23po
         5Mn4SVlRC35WUnMjof/75dZeaF0JUtX+1AH9JUzFa30GIP+jVlAYAh/Eom3EsnTVwzUt
         wquAFfBvRS+wh7kmt6jHuBN4FHjfyHNY2w/KmxPZjiz4UVi1Q7k61fJxSlGskrZspQwG
         Wa9O8TnrUzwvr7lVorwDodkqFEiV24OOoxcU9I//bhObwxd4Je9UKmkTw+duIFIJj/7B
         KsbA==
X-Gm-Message-State: ABy/qLZm/tKwO7mjSyGJE6XuC5E5n8JAl0SYFU2ozMvw8ormCM+XC7wA
        LMeGXu7phPYTVBeo8Mytyq4G
X-Google-Smtp-Source: APBJJlF/fMjSKgm1f94N3y698IWtQxQI9hQtOC4upXLymQWnmYZfCL4lqoKB5A9jkm+5OU5jxRFzpQ==
X-Received: by 2002:a05:622a:3c6:b0:403:acd3:e90e with SMTP id k6-20020a05622a03c600b00403acd3e90emr28993085qtx.48.1689880005438;
        Thu, 20 Jul 2023 12:06:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ff20-20020a05622a4d9400b00403f1a7be90sm633051qtb.88.2023.07.20.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:06:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:06:44 -0400
Message-ID: <ee7d7edfda6279ee404ff1287625bd11.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, <eparis@redhat.com>
Cc:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: Include securiry.h unconditionally
References: <20230720015032.45960-1-xiujianfeng@huawei.com>
In-Reply-To: <20230720015032.45960-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Jul 19, 2023 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
> The ifdef-else logic is already in the header file, so include it
> unconditionally, no functional changes here.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c | 2 --
>  1 file changed, 2 deletions(-)

Merged with the spelling error in the subject line fixed, thanks.

--
paul-moore.com
