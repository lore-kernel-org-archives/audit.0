Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7294C04A94
	for <audit@archiver.kernel.org>; Tue, 15 Aug 2023 22:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbjHOWLJ (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjHOWK7 (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 15 Aug 2023 18:10:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C41FEE
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76714caf466so404424885a.1
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137456; x=1692742256;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3unScrRXv43WQA+MynDYU+5hV19Pl9H1g9d0YfpwsE4=;
        b=SBvy/9m5P2epu0i4uxixgn5Id8suYTQeE1NN7DZ+A18Hk/7T6eGmX01I3VhCncnmtg
         eXqOTIRLJcXALgGwmKIvNCbOgWLJdkU5kPJ1uA1KpRvvI2ABPO596ioNFI+KrERYol8W
         S/oojtxlTOZUIyYRNjv4fYFW79kh5nuT84zRotvBYIFPpRadHxLcYpyuW7sQThlZbKXf
         xtXZ2zi+u+JS76Hp28Jv/btB6XFoII9yAx88soA4T0dYJa5fiAtVQ1DfK+1A3QBDEIYC
         MB6A2GWlrOsDdujYU1+zGRzVvsKWdsy7UY4Gg+4OoCe3Ed47Zwpt/TalOVCC16P66ib5
         y16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137456; x=1692742256;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3unScrRXv43WQA+MynDYU+5hV19Pl9H1g9d0YfpwsE4=;
        b=LmUbL3GRGtJx52v75kq0v90Lt9SCSwIxbG9LTqPo4QY0+6RVaV3QVGybM+wY5CO2Pc
         WqIKcnhSbtUth+qHATvTKu4bYBwd12uKqynhTBs0q2ghYFkA6MtgS6irKSqltUxRvEfN
         TnvC734Jb2pB9r8QLv4k23YS52/UQC1yRbhPGEqcux0e3BEUkvYu69x/xcGyYG6wdvgt
         VBr17p1DqqhuF34FhZeyTmnyiL97pERmh32AVm41fP5J9bPeYK6C6t0pI8/ZKDb0g77i
         4zPHPfKIafUlLi2KpMkQ5GdIbg0K7MHKCVXeDrqSf3p7r76EwdTDSJ8Smd9QOuwtXeP6
         oBUQ==
X-Gm-Message-State: AOJu0YzJ4mfASHd72/qY6nGlmOz/0ljRyFM1CiDDyzCMadOgx9tGi2qT
        dYpHWQUhDKBP1M2K3dhX6K2P
X-Google-Smtp-Source: AGHT+IGlY9pOEe+b2UWKQVm4gn4podkZSAriIh+lc/ht2OtMhsFHyPAzzK13QqNIRbmZ51q16gKZCw==
X-Received: by 2002:a0c:da02:0:b0:641:8878:29a5 with SMTP id x2-20020a0cda02000000b00641887829a5mr43106qvj.61.1692137456053;
        Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a123300b00767b37256ecsm4030036qkj.107.2023.08.15.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:10:55 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:10:55 -0400
Message-ID: <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: auditsc: Removes use of assignment in if  condition and moves open brace following function definitions to the next  line.
References: <20230815204644.52358-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204644.52358-1-atulpant.linux@gmail.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> The patch fixes following checkpatch.pl issue:
> ERROR: open brace '{' following function definitions go on the next line
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/auditsc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Merged into audit/next, thanks.

--
paul-moore.com
