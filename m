Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0E1D63D6
	for <audit@vger.kernel.org>; Thu, 17 Apr 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865136; cv=none; b=rw+dqE9ftoYT5sLuH7BSEUON4JA3Ug913gJGgM5DFTBQ8YlbKadyIFjOkYb8rjBzLXANPZYBriuXedEFJ6dQW3oHx9krKPMKyAfznYf40hGH7m7hLgqi+APAX6ItU3F3ln/8/l4dliImNEC3S16Ur7NmWHgdWwTcUKY+5dUPIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865136; c=relaxed/simple;
	bh=xyTfxJPjT/FT2RxrfLY+7Sni/T27OxSE8JwnzRMqPaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ucbsp7bYw2kfhMAgHC6vqfJFiEk5YaI7z1h1y7Czl81CdBcOBthNYL+9LS0YXrKkCjaCrJYkSki+xeuN9gO6HQ+L0qBIHGxRDu00WVlL8d+QzyZk7FucGWR/ipgvp7LshaG1KTrUDt2PN121xM8gyIXJzzFUUaUqdREy69WKOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UblB/rj2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UblB/rj2"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70427fb838cso2614007b3.2
        for <audit@vger.kernel.org>; Wed, 16 Apr 2025 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744865133; x=1745469933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hK+UoriaNocNLwlVFNPRQ7NggNZSSb8YUIYC9+NMLvA=;
        b=UblB/rj2tw34xOjF2DI30ieD+dTEck5Vfg8o3QzI/75XZKyxJw+PId05lk6xGWK8qS
         Aersdh4D9dpG7nZkKoiLZrtl7Mr7NBQ2F4EjyDwnVuIgqhvfhmsQkP4Mi+LIIGb2XP20
         FHNElK2q7ptSQchblP74gB+tYF5xjG4HZcfgWkkMBKBrzlaJrgl/e+X/tqKEz46BGoEK
         wRbkH7I+HSwvKi2zKcnHkQjCul2Hft+vdsNNmmcg11DaUznMugpabtDBDerP7pRW7TP6
         0MW9X92Ic5eyp2ozuiP0sV6RaV9z8+91JAt0JP//fcBxVCYJ31N2ata4D0a1xzI8tCgg
         OQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744865133; x=1745469933;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hK+UoriaNocNLwlVFNPRQ7NggNZSSb8YUIYC9+NMLvA=;
        b=PLPPwdNQ2NOOmiqyyrnQqtqYyxF3J0AnS7214VtY9AsPH3IdsSAwEQm8uvGr88TnX/
         I1w3WcA6QvKd2rwQMdyc/mVyPyWnA/hu7KuVhW86cj/Btz8XaszbQnJFxGG55L0ujixh
         3xzvOwgne/YQjnFXGF+hib2yFYZmZus89ozmFlHz/ps2TxW41FqdwMN2V/EPKBqXrIQo
         NiZaoo2GQd3W0B2U2gtjvKFh5xQrlwL7zV5lprSu3D/1yle2oYmYiTvnhKCIPe8rHrTc
         6QJrCJ5A52ZiNa2tDvRi5tnSdNUKBa6jIjeFRO7LrvKolWRd9wCZHjj35J4gBfxoU1r4
         Yr1A==
X-Gm-Message-State: AOJu0YxzU50fGF3s3Ut5uJYyDWsZV/eBUZsOW3a8VQaGpH101b89XtuA
	DaVKADrpqN3tB4k5jZ/uZlhg0C2pWGzWTN7jVt3WEJknNSEHvdPxZfQ9RUio2hnAH4h19cTQMi5
	7wHBCQNxLM8Ifke6AyvBp7a1hqVfOiePZDqptfWD2VOiqtT3mAQ==
X-Gm-Gg: ASbGncsv/07x5dqHvpxvhMi84aHaqkY0y3lCRh4kZECrSqX/zYbGN55qV1v8z/Pxr05
	WeCXBiN84UYlATzUA5NWFfZhwMvjp2WIS2ISyPd+unPxrOWwWR8SlDgDTZBYyz36OWLc1n/9Axu
	KahQwBGidq7JI0qOysIco=
X-Google-Smtp-Source: AGHT+IHaaTXDxyzkI34Ogx4z396Q8pYsyPH6u8aitww6kJRPq2b5qvbBdxSj7005/QZyo9PV84jhijIDVkGDz1DLYvU=
X-Received: by 2002:a05:690c:45c4:b0:6fd:33a5:59a with SMTP id
 00721157ae682-706b32d5540mr65290467b3.18.1744865133397; Wed, 16 Apr 2025
 21:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Apr 2025 00:45:22 -0400
X-Gm-Features: ATxdqUFLjA9f3XxN-vWqT9Z0Rh5C33tqTW6J2RDudx4va0RmWzgc58zP-cWSx6E
Message-ID: <CAHC9VhT=reDcOFbESm+A4iePM3MBm6BkMxneTf2ND=-63-Qm-g@mail.gmail.com>
Subject: Regarding patch "fs: add kern_path_locked_negative()"
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Christian and VFS folks, when touching audit code in a patch,
especially one that is going to be merged into a linux-next tree,
please remember to CC the audit mailing list.

https://lore.kernel.org/all/20250414-rennt-wimmeln-f186c3a780f1@brauner/

-- 
paul-moore.com
