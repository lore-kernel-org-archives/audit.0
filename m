Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0149C77B7A
	for <audit@archiver.kernel.org>; Fri, 19 May 2023 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjESUyu (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 19 May 2023 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjESUys (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 19 May 2023 16:54:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C43E45
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f68eb91316so17375101cf.0
        for <audit@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529680; x=1687121680;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEDErbKnDGyXH+lfOvpQDyyAEEG2NpiC+5fpLiNmj9E=;
        b=LimJZkMRsJLWfeHb2nO6LTXjKeKZWqRYQueh0ON/UMzR84F6/CgY+SQYOeWL4E0XRE
         0HSb473/lL38cXrAKcFH7pmi7EuN5T9u7i4rc2ReTUIliGN8elBDkamdVGWQRdJxmmss
         +Z3stulSjeCIibUWxtlOEnbqQVEyXqzKEfvHcOm5NQvsEFtYJ8Bom+fnMJKuIzuryxb9
         6sJKrUHPGutOWb1Coae16vm/qxy3Q3CZe4koU3DusFoYFGqLmBETUyAV1PfXkBaipvXh
         yIz9bsEJswMFJ+vX9qdh/aSZQTBR3uNALhI8kCi/gWyLy/4oE3j5hf2DoW6kKACvjOvz
         J1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529680; x=1687121680;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEDErbKnDGyXH+lfOvpQDyyAEEG2NpiC+5fpLiNmj9E=;
        b=gqE7vnkBXfUc/sgnOPhDwEZyrhTdvqEAiZrrWI6BpbjHwI3Map5nDOALeNE1+sZQeJ
         G0nFtjuG/DKUN1svm27u78o+zTFOa8gjSAClapEdN5OguDclwMXusm3DP97c9VI6tKCT
         klj05KFK5QZIteNqS2/hcyqdIuc5Ez7tTXg6v6UReIwIFjNLBfGuRdRFkClAkNUN7DZ8
         BkI9ia/VNiGg3y9ZcEM4CfHJdVwQsBCZUFAS7gWpWwf0lOfEscazXhSJ6CnMp+5mHOHV
         /8jhdNu0UBBUKYj9I/L0o4zUBM3hr5wvFjG7KxdZHlAy8uQWWufnJ8Bdnw5zZXXsxlcB
         OJGQ==
X-Gm-Message-State: AC+VfDwTR7Hz7wdk+nEbqGe5Kq/sKmjflsw6UHCUvTfsQaJgsNhx5+Tu
        Utad1GldIxYzwJ078Z3xmxTv
X-Google-Smtp-Source: ACHHUZ4E46IxLqXiq+Du2QmCpt+yW5Xhph/A3cd+zEaUfFm7Kfu7a+6nDxmOyhNEWuHEJ2kGqkBTaQ==
X-Received: by 2002:ac8:5c54:0:b0:3f6:93fb:dbf3 with SMTP id j20-20020ac85c54000000b003f693fbdbf3mr5637977qtj.52.1684529680106;
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id ge22-20020a05622a5c9600b003f521882bc1sm129715qtb.7.2023.05.19.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:39 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:39 -0400
Message-ID: <8df851e887b1bc67434a3fae877d7cd8.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 3/5] audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
References: <20230511052116.19452-4-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-4-eiichi.tsukata@nutanix.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> As there is no need to use DECLARE_WAITQUEUE, use simpler DEFINE_WAIT.
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This change looks reasonable, but it needs to be reworked to take into
consideration the comments in patch 2/5.

--
paul-moore.com
