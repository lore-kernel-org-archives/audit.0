Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ACC61DA4
	for <audit@archiver.kernel.org>; Mon,  6 Mar 2023 21:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCFVpA (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCFVo7 (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 6 Mar 2023 16:44:59 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52DD36088
        for <audit@vger.kernel.org>; Mon,  6 Mar 2023 13:44:58 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w23so12306879qtn.6
        for <audit@vger.kernel.org>; Mon, 06 Mar 2023 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678139097;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGCtZhCvBrmkG71yYJVfVkKaj54y8cROoeWfSF8dsWw=;
        b=c9AaFh809isvZDIbDERVt5CqGx4hbGAZ4KW0lQpDFjvvuF0N2SCRUTkZlLCixrMoC0
         u0G4Yn4jb35yeXdFLlQyeFN4gmtfuCS+lCN4qN91B4MMi/tEK3tJ9S/yPV313/PAwYHj
         0q/HaOq5LDRhZcAjuwc89mBzc+qmtu2+hfbvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678139097;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGCtZhCvBrmkG71yYJVfVkKaj54y8cROoeWfSF8dsWw=;
        b=eIvmaJYJa7CEEN/Ssz/AvIu4KOMVqt5hAKIkdMA0wH2LnwK3N3TnVZ/vUccRgmfYMU
         J3yImx4o8VIIx/BsA8sIw5aT/z7NM1lCqTpPO/PXorv9W9fH6V66dTzN/uTVV1dnakj9
         Mfz2KGPikNBxYASrBi8VQv47Don+oFi2DtF9UDcfnCs0XQvVcVZcszOPU6KPvVIQ5ceC
         eYosr3NLFlIjV9w6Bg9HluQ6gBn9tlafe4WlEbXDTBIPtPjittcws0NlqZt175oDeozX
         H4dIFPE9N/JnqIaOK2vMlF5Gu/eCiYGXvV39aBLE7Mo6ypDphIEPxYIfQ6tM8Ea+RiRX
         yrdw==
X-Gm-Message-State: AO0yUKW8vAxcaITnEf63g7nUH2DGjQHSNoeFQGMX5SB8ZP+zcM0AlOxB
        FUGi1r0cFrLynccCwgbKREcE4OCrroJzKe3FjpU=
X-Google-Smtp-Source: AK7set+tCcDUtp07FtZYSKhOn5OcwZ15f7H4aIUgMXQxDzTuCTvPP+qz6nJ0Cc67eUiMk7oWANqgQw==
X-Received: by 2002:a05:622a:1992:b0:3bf:e408:6c91 with SMTP id u18-20020a05622a199200b003bfe4086c91mr21759586qtc.51.1678139097587;
        Mon, 06 Mar 2023 13:44:57 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id d82-20020a376855000000b007419eb86df0sm8222960qkc.127.2023.03.06.13.44.55
        for <audit@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 13:44:55 -0800 (PST)
Date:   Mon, 6 Mar 2023 16:44:53 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     audit@vger.kernel.org
Subject: Initial message to start the archive
Message-ID: <20230306214453.7pjr2shtytvsob3b@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hello:

This message is to test delivery to audit@vger.kernel.org and check that it is
properly delivered to the archive. Please ignore.

-K
