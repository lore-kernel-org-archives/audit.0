Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB7AC77B7A
	for <audit@archiver.kernel.org>; Thu,  8 Jun 2023 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjFHA2Y (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFHA2V (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 7 Jun 2023 20:28:21 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A1F2694
        for <audit@vger.kernel.org>; Wed,  7 Jun 2023 17:28:10 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565a022ef06so87117b3.3
        for <audit@vger.kernel.org>; Wed, 07 Jun 2023 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686184089; x=1688776089;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vw0UmyCBzJaxA40nXGuO0STQwxzqxXL62xDaxLAoA+Y=;
        b=FvmBa1YOO6JE7JGTlx1dD9JmoMiXLTucjbbSL4B0YPQ6bl1RySxavimXM2Y1rJjI05
         onGWtUaPNgjVrh2/Rz+hZc+pRLp17hDEEeN3E1B062bhC7I5SSMcs70GPBw4OPORVL2w
         j4QCmTYYB4Agd0QeWucnupgT2E0jSvrQ1iBlAi2Hj/LxgEetggLOlpzL0RE4Fg4lHafh
         QZLEDocl0FZ8MgQ0FexS8ihawBT/1PSLg9lXpUKQ/4PZlnwYmeI1dxgWHxulK+dvvJm0
         kfMdUl1bafosrFdElfRzvSzqT3nmHuZPhJpLN9RMAdyX2jYpHTjHNCKT5MRHfXFxew/G
         yXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686184089; x=1688776089;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vw0UmyCBzJaxA40nXGuO0STQwxzqxXL62xDaxLAoA+Y=;
        b=Hux6WfgGcFu+T7A4lHPqPqIp7XBTSyT0oJ6MgptTF4sBm5cYBvMhF81a44zDEyYuor
         zn0OxHEocwHC0YLdyqJxwjbI+kYaxL/8GQ8h30fdAh8c59OjcRFY2h1vgDKD0oFUKQjr
         z65OkLJDQwLDuVg0WXbWCKb1odcO4131bZrvUU7sP459bqS1/TlX+GheubfN030JNSCq
         /dnNW/RP/9/wmFd0zkQKHY7XnOoHc8rIvy6J07xIbV3O5l3nlR86xDePwe9P5YwYaZQy
         fPVKmY4EN3azZHczOAFBCv+nG/hcMQH+ha/sht2MGIFrZ/H2P9qokC32yiZ8VKQTAZYf
         wGEQ==
X-Gm-Message-State: AC+VfDwICAO8JWcKzwlkv0JX4M0dP+9330bYDurv/zGU9PV54Q48Cdgc
        whofKLF3D55TPlPxby1sjbjgkIIuMT2sRQsh0rat9rcfuw2ZrJNXKw==
X-Google-Smtp-Source: ACHHUZ7wiFDBLRch6zJVVlRfMnpoQp8i6I+ex8f42I05+Lwf91eewCXdyOfu8rXM7YNrzIM11u7WficGf5vGYXQqwmo=
X-Received: by 2002:a81:7bd5:0:b0:561:e8d7:ac6b with SMTP id
 w204-20020a817bd5000000b00561e8d7ac6bmr9635791ywc.49.1686184089638; Wed, 07
 Jun 2023 17:28:09 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Jun 2023 20:27:59 -0400
Message-ID: <CAHC9VhTBi57zbrf6xPnaxpY8S8Z10PzENR75FTfSNR9qcGzYzQ@mail.gmail.com>
Subject: ANN: audit and stable kernel changes
To:     audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hello all,

After a discussion with the stable kernel maintainers, I've learned
that they have a list of subsystems where only commits that are
explicitly marked for the stable kernels are backported to the stable
kernels.  As this has always made more sense to me than the current
approach of simply backporting everything with a 'Fixes:' tag, I've
asked the stable kernel maintainers to add the audit subsystem to that
list.

I don't view this as a significant change for audit since I have been
explicitly marking stable candidate commits as part of the normal
merge process, but it is something to keep in mind.  My hope is that
this should help reduce unnecessary, and risky, backports.

-- 
paul-moore.com
