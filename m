Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD567C0015E
	for <audit@archiver.kernel.org>; Tue, 15 Aug 2023 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjHOWJa (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjHOWJW (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 15 Aug 2023 18:09:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FAE1FEE
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:09:21 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76c8dd2ce79so520676685a.1
        for <audit@vger.kernel.org>; Tue, 15 Aug 2023 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137360; x=1692742160;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P+y8qETZYNAegIOhFR4VJ0g7JbCPf/QOcti2iqgt86Y=;
        b=U9Srv10FGBxw3+U/yoCZTkKg7qUB6Wd/5rVFj++n6I3KAcE54o2N/rqoPRn1picQwz
         +pbFzaC4/3tYJZoC8usC0uRgxX3X4QDhsdkBQcRwdDP8A6i41f9xnzWwhOahuDuZskqZ
         fEQ3fidLQkfF8WpVNoAwaKK8hM/5ADbEIGR5RC4is7Uwa//Xhv4RlYHuAexoTbbV0KFu
         Dfg6xyUymxBQIeCpBxuQqjQN7M5w5LDFyh2EMsHhF2uWa3LnfG2GWmZ/mWDbBOXC6jn9
         xTC+5GgTXTahh2Q9E9yN5g/My7qXKDlHUV+niRbXFhtsvQwHXvMi5DTLRuHjaJU7IqA7
         49bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137360; x=1692742160;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+y8qETZYNAegIOhFR4VJ0g7JbCPf/QOcti2iqgt86Y=;
        b=dWMeU6c6wrN5OtL8GMd1OXPqhv03OyQLtxHQ5YNNG214jWTPKFZlN67sEM3UMKIR/P
         SQr2+HQ6JEQRyHdWr9CKyB86e/C2aclEyXE2A4ktMeAbYoFCtZUm3hdDepu7T9146Wwt
         lmQKDmpomi7mkANWLQYSz5gm2K9PMzObSXlw+YfT+bOhSNrCrA703ZDb2ipiFfbUFu5w
         lxPBnkn29UiCsXX0bJirOf0XlXRgNsRnoNsVP6zL5GHOqq7ehb4CW2xrZ8lthWcVF+iY
         vlfvrWq/23Ns3XQHtsixRkJP6yKoscjXrzgrzq5alNFogJgR7Apw4FzbOdCyxnAvd5Yr
         RbqA==
X-Gm-Message-State: AOJu0YxPhx1LmnUJTw9G9qEeAmayYQUklMc583rsCumDCetbrJ71ImPX
        j0vi1K5pFd3/C+M+xptm7v6b
X-Google-Smtp-Source: AGHT+IEoxf2tOUQFGE1k20XiwUYizctfQkxWty9Jz+mUFWEiy3ZPDKtu4qfbZdOFt39QNXAkQpfg5w==
X-Received: by 2002:a0c:e0d1:0:b0:641:8c0f:1a3a with SMTP id x17-20020a0ce0d1000000b006418c0f1a3amr13871qvk.53.1692137360168;
        Tue, 15 Aug 2023 15:09:20 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r4-20020a0ccc04000000b00631f02c2279sm152277qvk.90.2023.08.15.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:09:19 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:09:19 -0400
Message-ID: <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: Add space before parenthesis and around '=',  "==" and '<'
References: <20230815204553.52261-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204553.52261-1-atulpant.linux@gmail.com>
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> Fixes following checkpatch.pl issue:
> ERROR: space required before the open parenthesis '('
> ERROR: spaces required around that '='
> ERROR: spaces required around that '<'
> ERROR: spaces required around that '=='
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/acct.c        |  2 +-
>  kernel/auditfilter.c | 16 ++++++++--------
>  kernel/auditsc.c     |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)

I changed the subject line to "audit: add space before parenthesis and
around '=', "==", and '<'" as the "audit:" prefix is more appropriate
and I'm a believer of the Oxford Comma.  Otherwise it looks fine and I
just merged it into audit/next, thanks.

--
paul-moore.com
