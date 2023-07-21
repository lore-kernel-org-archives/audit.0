Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C5EB64DC
	for <audit@archiver.kernel.org>; Fri, 21 Jul 2023 16:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGUQTG (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjGUQSk (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 21 Jul 2023 12:18:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368C44BD
        for <audit@vger.kernel.org>; Fri, 21 Jul 2023 09:17:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7659cb9c42aso189592785a.3
        for <audit@vger.kernel.org>; Fri, 21 Jul 2023 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689956245; x=1690561045;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqfQ3B4+VuBd922SBl1y/3NgJzQmtJe4fT7OCLYNoiQ=;
        b=CqOIyVOX3RihhCbRjjUBKcSr6Y6wwwqdJSqkvDqeoI0LAHT1T5MoMmsbozmtvgrvAv
         Ir2/YV5YOWbV97aPA0erpe3Wfl9Le+S33jqg6/VnUlRyshtX5crcciHOAYgnXKvdr0pU
         wT77av8dFeZlgGqQW5wuXjorFiplm17dPWhU0bs0e8hLCNO0DxVcC4lnddeT/UL9ENXN
         PTrbv7Ni1sNG3iMtwpGlCP4PKwqlZpREsccqfhl/1b9wM9a4BePR+fZgmW/RpESIKt+u
         h2LpS9lX+VQtQxkUODQ2Hesx7sLFcoXjdQiIRnHluB93IBAhJRd47fpg5cGZqqwIBAyg
         vRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956245; x=1690561045;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqfQ3B4+VuBd922SBl1y/3NgJzQmtJe4fT7OCLYNoiQ=;
        b=RvVQhHMwwutp3Z/8OBjzXYdljsvahBePdl68MjrOdG9ksbechYYH69h7zq/lSoIJhX
         iiBcitsVlesnIBjJTuWE9aoab+CUWZs+dNcgP+5i97NofA/w0H6tJ63z9UBpKEGPr0Er
         HkFHg5z36CTAVOBBE9MjAcDN1nPqvUggf0jWlewLBAcvX/ArMYAuNfAuARYb4JtEy/cV
         r7UbsLSbJJsQQ19/2Lq+GQ4vKF96aEdgi8ZFdBrLfi7BK1AfcmAY4vWgwhuK82n1Lc3+
         gXPjMp8ULenBovDtq4nPIzE+q+BkSjIiud6BnTKjtR8FE1dc1Gj2Ls1j3E0S8GOfoLyb
         QHPQ==
X-Gm-Message-State: ABy/qLZ45bPdisA4RQN1z/EnJ4Cs0XSZRCpY4nXqB4MQpfKCrorsDERj
        RNZetLy6Meo7CaGFemoU2OKCfIIZXFY6/yZWgQ==
X-Google-Smtp-Source: APBJJlE866PIhaxkT6jyhnfTRaN5FvYQVf0UFFdQke701sBz9E36ZY59fHn4miEr6ScoK3KohKURmg==
X-Received: by 2002:a0c:ca12:0:b0:62b:68bf:7c6c with SMTP id c18-20020a0cca12000000b0062b68bf7c6cmr490904qvk.25.1689956245385;
        Fri, 21 Jul 2023 09:17:25 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a109500b00765acdc4f56sm1204696qkk.60.2023.07.21.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:17:24 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:17:24 -0400
Message-ID: <5b6c88a6762d471367b390aa4ac07368.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, <eparis@redhat.com>
Cc:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: correct audit_filter_inodes() definition
References: <20230721112101.176222-1-xiujianfeng@huawei.com>
In-Reply-To: <20230721112101.176222-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Jul 21, 2023 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
> After changes in commit 0590b9335a1c ("fixing audit rule ordering mess,
> part 1"), audit_filter_inodes() returns void, so if CONFIG_AUDITSYSCALL
> not defined, it should be do {} while(0).
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

--
paul-moore.com
