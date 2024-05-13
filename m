Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AD1C694
	for <audit@vger.kernel.org>; Mon, 13 May 2024 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620529; cv=none; b=owsTf0MSaK7WMQNKRd2ZnY40vbEPDwQx88oQz40jGQaZfHcDXJ5XNchftjk+Q3hsTkfJRQWipyWrMFFkywyG6EStsAMdEZBuX4RF2Kb4GZJc5MlX9svAo7/5VyiVLFoONYum2DTOZ1w1rFKHiKUMKsERlW2s5COhjE22s2Ndj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620529; c=relaxed/simple;
	bh=xPN+ITOoXLdVCdMAvOuJKmRhvDs2qzFJlU415xFsXFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vEmcb8d3vyJHvJyBivVV9LeOXn3lskGT0KSsDA/vwHQVlqPGWh6zHKbnHeOo627Qw0FnAISYDf6sQegh9xtztpayMGKUiM4F240iZ9podkoykfc78nYtLAIUXiExPTXEDlxVstR48x+3v5o0G1DLNg/IvmbzqjrbAx+Ev/U3Pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e15WROVb; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e15WROVb"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dee72970df8so1422709276.0
        for <audit@vger.kernel.org>; Mon, 13 May 2024 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715620527; x=1716225327; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m02DXhTyZZTSdb/f/ewvk3SI2hm0TRiFGK6xEmLxZOI=;
        b=e15WROVbg/kXI4RC0+FS0xEbcJ7pqQMtTUFGHiwyu3is394gQIKHJPQD1U+JpyLRzU
         yPIgTq87O5A6Ebf1uat7vNcRAs5KVClODx0kvVg7Q9wr2AV+w1DGAy/u07Y1a4Mdgv+9
         1tcBhzjbhGKMoS4hwi7efrTwc5T1//beaDG4fhhLiJTsdMSEjGIgfaXVyGaJoF4ZsnLZ
         Ph/JutmH1yFtZelWBzWy1IVOH0kVNVxNDEJJKgtLm5Q3/tH8IT8vrME98IPXPLNHrYYo
         bpxVKCU1NuKc5myKtAtjdYez3xioiZV3j5ZaG+rolz9tHaTktG52LwHSX4d/+TU6gn/S
         SQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620527; x=1716225327;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m02DXhTyZZTSdb/f/ewvk3SI2hm0TRiFGK6xEmLxZOI=;
        b=vjTyxdJv8w5h3nBrRtu2AhVM/dEkGQZJC6DRKJgaMKEHVAOItzbEc7X/zo1vy28ttn
         2qCV7eyPgGzMnwA7aYh5zeocm2Nu7L61vhbSk/0ez83YPV8k19U4OS0BhI4Gbge4E4vn
         ofeLudH0NQmbWPlrkSlBOW0hisFoQhLnN03Mitsh9d8IBYHT/+HeRzK8omVulxa41Yqr
         tA5KF4n+nZ8ZtNBHUAc/LSL2PScVkNHrEswwzcdK0+oX5TMdmYMCMBVDS7x9I/b9jPEC
         9S+PtTfunyktizlfhzRj7W+ma0vPXgLiIea3Pl7zmeKHENWIMiMxidC0a7lN3XAo8Pug
         pmrQ==
X-Gm-Message-State: AOJu0Yxh57R7iE8BW2z3hVJPPDHaO3horAoDMNm0lrjmDgWcPo/YmpUf
	/E7h7CbXHvxw7gzWqpFJF0qe4ZZTXyMT2qvf5WKjmylqOAkaCpPL3VsSnAcr6zfwROuWHBbu5t+
	YOgvHrMk3nmXc1i6oa2MBl/idbWT/GnMf8w3JKliGxTG1Zo0=
X-Google-Smtp-Source: AGHT+IGaDR8y89Bq6zrCv9iui05ZXHm9DinvO6Ntl92D0V4AgI+OYdtI1N6itLKe+SFbQLVtdncWlDMw74lsSHQy4jc=
X-Received: by 2002:a5b:1c7:0:b0:de8:b43c:14ee with SMTP id
 3f1490d57ef6-debcfc36c7dmr9473205276.31.1715620527179; Mon, 13 May 2024
 10:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 May 2024 13:15:16 -0400
Message-ID: <CAHC9VhS4a=31ObtxsYwv+_msd5476krX5RhOds5_yJL7K=iCmQ@mail.gmail.com>
Subject: No audit pull-request for the Linux v6.10 merge window
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

A quick note to let you know that while the Linux v6.10 merge window
is now open, there were no pending patches in the audit/dev branch so
there will be no audit pull-request sent to Linus at this time.

-- 
paul-moore.com
