Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A624C8F
	for <audit@vger.kernel.org>; Sun, 23 Mar 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742759051; cv=none; b=VuZH9P+MR9vCk1e5gof15v8asFhxlypcfBM15HDiWLnFJtCQibzYyyV6+ggATGPTxzCVPInloH+n8DeJWVlVwrAdsxOuSCqlLuvmvddWCVjC4QMxRA9CYtMd6rNd3/HqrLr0+KdQWkPlVjH67ychAFlmZF4VxxDg6l+8BxYhuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742759051; c=relaxed/simple;
	bh=6SDmzBNk8VVi93gt0UIQKBghLhjBHYW+oC4X0GOmMF0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n0yqqCUDrLBILC4iOTF78x8i9eZejZ0cFA/6sdyoQR2ff6OM6yvXoGQnQjEsyQ/dGSH+HLu98FY457PQCMkZ7qsnu1BebdGJIgahxif27L/SOnVfPF9aTvnY2HKsduQf1vqWJyBZCfhGE1ftszfBocJZipuApiwGJvmK0CG/IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=blMu9HCn; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="blMu9HCn"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6efe4e3d698so32369967b3.0
        for <audit@vger.kernel.org>; Sun, 23 Mar 2025 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742759048; x=1743363848; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dQpUj4yRQOwStm1CNvl+42T7IL3d8ttce/b0H9IIjfE=;
        b=blMu9HCnuPvZB2/xQ4zfszAaF2ytEz6ijPqdP+KsXxi/TbSiDPp7xqNkSdg2gF/iIN
         NIrBeFNI0QI5J8oGzGV8Hl5WzTPu1tkvC+ZEn6gvPqlV6Qc8ECq5nbx0C0RD8aXR5rAr
         jqRNPgwkYUFoVC6tnPrilz6WYEG2mYlV+PD1Bxrx+CgZJSGHkZf7CiidSWaGVPPdE1cw
         6cHEem6G207TeK6+8rd3UjZNKNkjxmDfypzD/n5L/vVc16b3nyEyosJqP3wGjHD0MnJ0
         NvdgPlsaoPUcByurs2zCvsYkfDNC0WcUE8WKdpWr1ZAy1tI1vlbmmC7GaDEWQ7Ku5UL8
         VhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742759048; x=1743363848;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQpUj4yRQOwStm1CNvl+42T7IL3d8ttce/b0H9IIjfE=;
        b=FYMq3GJgrtxZ6qxCNNe/4e5fbpJhq1CZsSOTupKU/bWtacLCqpc9vOWtGJJ+inXIYX
         SK9uT74VgmGqqzESM6jlv4vyLjy3LW0zKnINTN2c7EWuUf0F3SfblRVkhL1yASI6KBXN
         rSIWhawtAk9szqUgUVh4y0u9/4MTfuHFsPOaYuoS9XtkWudX7kwCw+6jU8/EHHOGIS8u
         P9mMfxPAY61iLYq3R5Mrxl6a0t+5xCIU9MGIVyAV/BZ5vjAuyials0pmPZc5rIZw1AOE
         t/frEd+Bs7/Fh+2tN5FbR5hF0H4hwSiQvguLo9zHFaBo12Vo/Os3YQMAB8e2GhXfKAv/
         2RXg==
X-Gm-Message-State: AOJu0YwfGBIAUUyYdHMmRACFuV3QIiAhZKAd0YY6j11Yy6OvwSqK9e17
	4AxdlBJs3RraQSDzRAzEwZk7iQkOvOBIIbkIWyP8VbCyRtka9osFREtUw/BdAFIJU3f05PL5Y1X
	+OAUarFC2PcHRbn7XwzBmk8iF+flka2Cd7qQDErMKYpFt1B8=
X-Gm-Gg: ASbGncsLmjs9hMOujK27ZTL1BpzWgAKJ9+KVVCst5Rwztq68Cww9mVqp7KItbC8IJVo
	xOH2EYKpL3K8PpKqXuvVqqhH3vnP2nNUGjWcI4tcqOjbSeS6Wy3f9owATTkBvowl1Prq75Bj5yr
	iXrNIR/gxdDJHNHFkWyuNNgk6bfeW2A5nvdgcL
X-Google-Smtp-Source: AGHT+IGsa7O8BbDn36oj0z221hh7SFGw6upT73hp1XysHtWu1h8SJeMRIgYujd7m89J5e1f6AdnVJ6+WQ5hgngJOFt0=
X-Received: by 2002:a05:690c:6809:b0:6fb:55c6:609c with SMTP id
 00721157ae682-700bacff5fbmr128725437b3.23.1742759048471; Sun, 23 Mar 2025
 12:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 23 Mar 2025 15:43:57 -0400
X-Gm-Features: AQ5f1JpmqdKS6Zyltm4wWFbWjphZ5TS3DyJSP8p1EPHPEuuG6ap3f43rd8P8g58
Message-ID: <CAHC9VhRgef3Sei1KcmSKbSGif_Ntc5WuMCaqAuvKPrx2aoG0sg@mail.gmail.com>
Subject: FYI: no patches queued for the Linux v6.15 merge window
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Just a quick FYI that there are no plans to send an audit pull request
to Linus for the Linux v6.15 merge window as there are no patches
currently in the audit/dev queue.

However, there are a few patches currently on the list which should be
candidates for v6.16 merge window assuming they pass review.

-- 
paul-moore.com
