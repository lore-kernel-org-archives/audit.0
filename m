Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD15131E38
	for <audit@vger.kernel.org>; Mon, 15 Jul 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072427; cv=none; b=OpiplCDb9EUlSBjy8e6sGStdWOQdamJKkCL9ID/wB3vtWITRFanLvSzQFn1LwF+45PI4z8NOTlptCJlvOTCAoQf5D0Fs1Baw97K59aug145fAhIMmSL0J/c435U3aNFvQQN/Ml+pXQzRUz2a0CvzCKedQ+Ors6EC3YUIPl2kERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072427; c=relaxed/simple;
	bh=Pd0Iv1O8PEgrlg4jpqWsd1xbS8cLVHpZw4BEyDtOjW8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j8fo6xVLWDI1AfUHgWu0KZ9JQhuIX+ZZF1X4nxYDPWibKcdE5QTrZMBDkNBytJWF7w/attqaAWVXCH0D/TQt/OFcT5XNzziNQldm2bX+NoTB84ux5vPb8mdHviYCHoVD0FLjdZHwruzlPA+1RVPxsKba2AZUntBoCuHCNCg4UrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Enes8aKW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Enes8aKW"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03c689addcso4689430276.0
        for <audit@vger.kernel.org>; Mon, 15 Jul 2024 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721072425; x=1721677225; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZXFNtxZB7SjSCrWDVnvo5FjZA/gpJfVit9Mb02tbBPg=;
        b=Enes8aKWz/Ar3UfVxic8tS8AnQnvGkhcCgiDxxWMPns5hR8tJtsrzJ8w9zGZ8/gouR
         Bqey5UIGxq864UiObt0QdFBTc/XXxtZ3mRENoCUHsWMEwok6bdtjQSuUVyRDjglgSMO3
         rNL96AEgQy65/Chhrh1GBOgsOncksg4K3wXHDsWIuJSTl5T5c7lgyKTybhF+4kGBve8z
         IjCOC6YLgxT4POmxCKMFHk3XxC0ZkqSHvH1SMIrY4YGZDDSft6gJM5oymyDBmyKF+n3Y
         7Gd23OYac0Y+pgn4LpaNxXEZisOE4d8Q5GzfMCi1B5GsWvuC7Xt0NXgc5plluIRn70VL
         M17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721072425; x=1721677225;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXFNtxZB7SjSCrWDVnvo5FjZA/gpJfVit9Mb02tbBPg=;
        b=miS+ko2NCG5OE/EgPNx9N618aN7bMxkhO0yhsILycbq5itkUap8HbM5cTXG8XrWdH5
         efWMERURhRjt0zQam0zgsRvVNuyFxqEnjNdHXq0bPsv9itRxaaeVXo+Hbpo5np0r7ilb
         5Xb23BQrIwR390ploMlZBvqd2C1aOTYxryVI4HIQa6MjVX9AJ1ww3Efn0cf+LMTc73vE
         O8QIGmMH1ewZOBQAM/eUHLsDjSgjd+uIeXsO9SeQZ/wctPoyqFUboWw7MWP276ebTOJo
         G9rLCSrUfsyRrS9+zsYWpIxaoYUovAh7V/h943OWxb23NQ/QCmDZqBSHZ1LItxEtydhF
         oIbA==
X-Gm-Message-State: AOJu0Yw5LaoKbUuJh0Rs8cGeW6KBg5DwhQDQ3ARxzDKFJEQHBbTw97Pe
	7WGWVK15CpKBZUqjbv3N89aG+5TMeTHwkS+wJGA/VfXQCZeCljUTksyKvcjGb8O5SBX6d7QMIKv
	tmuHjHg63vpa+LoxAYZVpybeMjqoK9+CVPAygk8UoBTZe1ao=
X-Google-Smtp-Source: AGHT+IEvv0JgDJJssVcxqwMbXlCiukOqa+/z8HosMPJplmc+f8DjxLoOx/wNnIVwWVN7NPxZDQWePVj4AbiopG6hL90=
X-Received: by 2002:a5b:383:0:b0:dfa:cd8f:372d with SMTP id
 3f1490d57ef6-e05d57ea7ddmr145738276.38.1721072424969; Mon, 15 Jul 2024
 12:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jul 2024 15:40:14 -0400
Message-ID: <CAHC9VhQ1Ydiq=XBGX7pR8f+H_QNOb8ubzUNgTnT1s8NKaoh-FQ@mail.gmail.com>
Subject: No audit kernel PR for the Linux v6.11 merge window
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

Just a mention that there were no audit patches queued in the audit
tree for Linux v6.11 so I am not currently planning any audit related
pull requests for this merge window.

-- 
paul-moore.com
