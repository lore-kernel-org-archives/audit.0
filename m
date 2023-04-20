Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82DC77B73
	for <audit@archiver.kernel.org>; Thu, 20 Apr 2023 20:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDTUcg (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 20 Apr 2023 16:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjDTUcd (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 20 Apr 2023 16:32:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52B44A0
        for <audit@vger.kernel.org>; Thu, 20 Apr 2023 13:32:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54f9d6eccf3so9351477b3.2
        for <audit@vger.kernel.org>; Thu, 20 Apr 2023 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682022736; x=1684614736;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Yi2d41KUiU6xO+AIrAZiENbx2C2WD3Ka19Myl8AoW8=;
        b=e0aigefdek5zCXS4G3mkEUSYT+e84NRqqMV1AWrgJp1anCstKpcLOyLTRym2kZucmX
         lOgGe1iZmAM50ZOfyP2H+eH/gbJaeLy6qg84u1WB4UQ/TP9U1wh9CG+32sEG+NG9tpvC
         tn5orGFRkeFAFcQWtGiEHHjv56WNueRjUZXE7aRUPEwFnsFm3JAzepEfWJpyVCFHHhh0
         LVAxn7crFoBzjbh3zlXc+jmworL40AREqo172c5JqJeAJJ/3kzI96xn3M2mRHdo5XZRP
         87Ao2GgxSI9bmVBrtZc+HRxtfHo2YYOFV9fsHqaTUlDB3K6FqnSgbeGmDDxqCOV4ny++
         6KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022736; x=1684614736;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Yi2d41KUiU6xO+AIrAZiENbx2C2WD3Ka19Myl8AoW8=;
        b=kDe/nn+l1iXY/DIUIQqQPPDUcm5zGBqWIu9ZmtSl1Ty14Ujk8wNMdEBy3BN9rNocnJ
         cjv2HJg+tKt1CietllAxq9hltKCBjRhoe/nYErxVimp2Xa0iawhGcklmmhRrL1LADz+l
         o/66Wqj+laRa1/KFMr+GeEPdNJ9RYpljcdJigJeBh1NFmhTX2zbeDznRcDVLLLUmptO7
         rQ5/+kUWMiSbEx6cVyeHydHyRvptFAwsORUO3e5P2otL3DnOWxBQ0k2W1K2XpXBODdFo
         l3NZ5U6OfTI68SAVQbQ7DtEIT1Dy8P9m28ZcJ7CSuaWL6gAbcY0QoWPvpLLgdPDS9aAb
         PLqA==
X-Gm-Message-State: AAQBX9fxLk06dm6Tewhvwgc5EJyqZn/NxDWvarie8jexRqLno1rsD2dx
        zA6KoANMnySgfI9PO0cMYliFxd75vHVU8u10s9wa13ILUtr/loc=
X-Google-Smtp-Source: AKy350Y+tbzioCYEIMSu72Moah8wP3bvIuGr4JpuOpttBrfQ7pgPJ0LKCXWSkcSeqLI0OeaaCmX+6a48WurVhzr8N8g=
X-Received: by 2002:a0d:ccd0:0:b0:541:8735:171e with SMTP id
 o199-20020a0dccd0000000b005418735171emr106313ywd.11.1682022736097; Thu, 20
 Apr 2023 13:32:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Apr 2023 16:32:05 -0400
Message-ID: <CAHC9VhQqBhgr6kbtyD0WhmDDU3DkKVqC2QDzCDQhTAP=pg3x4A@mail.gmail.com>
Subject: Linux v6.4 and audit
To:     audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hello all,

This shouldn't be news to anyone following this list, but there are no
patches queued in the audit/next branch for Linux v6.4 so there will
not be an audit kernel PR for the upcoming merge window (expected to
open this Sunday, April 23rd).

-- 
paul-moore.com
