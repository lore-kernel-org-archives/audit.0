Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6210AC7EE29
	for <audit@archiver.kernel.org>; Fri, 19 May 2023 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjESUyk (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 19 May 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjESUyk (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 19 May 2023 16:54:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39EA18F
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74e4f839ae4so201618785a.0
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529678; x=1687121678;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EftTN48XIscLx2uPCkmTyhD/m2bm/FDn6sy7vahCgjE=;
        b=T7FKOsXM1ouz72HThuuahoyILhW+FggCWQ0iUHvRy8NX46GoZO1s1XPgTMD5+zu8yW
         H8gd+7zo2OMD0QOAtOZUJRfxtC3qvcCU4fHiqXCWGLATXerO86WECoCIcyVV3WYjBYMA
         Ar4QUVBJY+kZVggbjC2kTWOLtwA14A0xp2txTBgBzH0/TIATr4dz5NYHOPtmtmMMZrdT
         hwUhCyxerV44prjl1aOLDuao9IXmhbj2vbnG2RlNvW1w+65GgO1KcKI0p5TdE8p23Irq
         ftdl+yICQ4jqVm4f6dRhcODUemWe/hn8o61kZBSS/VuymVpryo0fwpX3zhZLJiLiqLw4
         vnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529678; x=1687121678;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EftTN48XIscLx2uPCkmTyhD/m2bm/FDn6sy7vahCgjE=;
        b=QAq76p0MpKJ6LQOZoSFfBw3IcdbaxKr6X4+mWoTpU58JYLyWR3GRyJsI/eAOwEcgnh
         yNZ+czlNZNyQET5ts4wHE81/GYY+r2jgZSVIr3oRYu/hu5aunsyOAYUvcuCLaP8fqW8S
         3+Dy/appQSgoVJ2Z7dXf8wQTRVBwE50wCr9UP4AHQt5CDdomkeVK/olexqiEXVQkjo1g
         WYaa7RaDLLdYJnFZP5Xxd0ckwYUQr4rRLbW9j2wY9ZCfjHSD76Q1jLE5tY4S6FOs78M5
         jq+W2bKg/pIk6JTct9J5C9JtZ6hEwVrujhqbVOFgoMrTNEZsZ29eptW3tzlH9In2reJu
         O5Xw==
X-Gm-Message-State: AC+VfDyUv0aSEEGtb664qtsQTI++TWdFuvrcotboRa4JX3Pfjox4aZVx
        KBrwyFrx6l8gp1hBf1VNDO5ZOarMegd+2s47DA==
X-Google-Smtp-Source: ACHHUZ68wdbTYWzckk23nVLTX5UsgqPNSlaIiYcdUsFAJJ5/q/X/NUngCpJuNjGWGwrpc6B8K/Chsg==
X-Received: by 2002:a05:622a:4ca:b0:3f2:1778:813c with SMTP id q10-20020a05622a04ca00b003f21778813cmr5339882qtx.31.1684529678042;
        Fri, 19 May 2023 13:54:38 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84688000000b003e3918f350dsm123813qto.25.2023.05.19.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:37 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:36 -0400
Message-ID: <1be99c1ede70b5c385acc16b59347d02.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 1/5] audit: refactor queue full checks
References: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-2-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> Currently audit queue full checks are done in multiple places.
> Consolidate them into one audit_queue_full().
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..c15694e1a76b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -341,6 +341,12 @@ static inline int audit_rate_check(void)
>  	return retval;
>  }
>  
> +static inline int audit_queue_full(const struct sk_buff_head *queue)
> +{
> +	return audit_backlog_limit &&
> +	       (skb_queue_len(queue) > audit_backlog_limit);
> +}

Regardless of the other patches in this series, this seems like a
good candidate to merge, but could you make it return a 'bool'
instead of an 'int'?

--
paul-moore.com
